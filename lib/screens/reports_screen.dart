import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:isar/isar.dart';
import '../providers/providers.dart';
import '../models/session.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير والتصدير'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.analytics, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 20),
            const Text('تقرير الوردية اليومي', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextButton.icon(
              icon: const Icon(Icons.calendar_today, size: 28),
              label: Text(
                'تاريخ التقرير: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => _selectedDate = date);
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: const Size(250, 50)),
              icon: const Icon(Icons.table_view),
              label: const Text('تصدير إلى إكسيل', style: TextStyle(fontSize: 18)),
              onPressed: () => _exportToExcel(context),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(minimumSize: const Size(250, 50)),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('تصدير إلى PDF', style: TextStyle(fontSize: 18)),
              onPressed: () => _exportToPdf(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<PlaySession>> _getFilteredSessions() async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;
    final allSessions = await isar.playSessions.where().findAll();
    
    return allSessions.where((s) {
      return s.startTime.year == _selectedDate.year &&
             s.startTime.month == _selectedDate.month &&
             s.startTime.day == _selectedDate.day;
    }).toList();
  }

  Future<void> _exportToExcel(BuildContext context) async {
    final filteredSessions = await _getFilteredSessions();
    
    if (filteredSessions.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لا توجد جلسات في هذا اليوم!')));
      }
      return;
    }

    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Daily Report'];
    excel.setDefaultSheet('Daily Report');
    
    sheetObject.appendRow([
      'المعرف',
      'الجهاز',
      'وقت البدء',
      'وقت الانتهاء',
      'دخل الوقت',
      'دخل الطلبات',
      'الإجمالي',
    ]);

    for (var s in filteredSessions) {
      sheetObject.appendRow([
        s.id.toString(),
        s.device.value?.name ?? 'غير معروف',
        s.startTime.toString(),
        s.endTime?.toString() ?? 'شغال',
        s.totalTimePrice.toStringAsFixed(2),
        s.totalOrdersPrice.toStringAsFixed(2),
        s.grandTotal.toStringAsFixed(2),
      ]);
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/GameCafe_Report_${DateFormat('yyyy-MM-dd').format(_selectedDate)}.xlsx');
    
    final fileBytes = excel.save();
    if (fileBytes != null) {
      await file.writeAsBytes(fileBytes);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم حفظ الإكسيل. جاري فتح المجلد...'),
            duration: const Duration(seconds: 4),
          )
        );
      }
      if (Platform.isMacOS) {
        Process.run('open', ['-R', file.path]);
      } else if (Platform.isWindows) {
        Process.run('explorer.exe', ['/select,', file.path]);
      }
    }
  }

  Future<void> _exportToPdf(BuildContext context) async {
    final filteredSessions = await _getFilteredSessions();
    
    if (filteredSessions.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لا توجد جلسات في هذا اليوم!')));
      }
      return;
    }

    final pdf = pw.Document();
    final font = await PdfGoogleFonts.cairoRegular();

    Map<String, double> totals = {};
    double ordersTotal = 0;
    
    for (var s in filteredSessions) {
      String type = s.device.value?.type ?? 'أخرى';
      String typeName = type;
      if (type.toLowerCase().contains('billiard')) typeName = 'بلياردو';
      else if (type.toLowerCase().contains('ping')) typeName = 'بنج بونج';
      else if (type.toLowerCase().contains('ps') || type.toLowerCase().contains('playstation')) typeName = 'بلايستيشن';
      
      totals[typeName] = (totals[typeName] ?? 0) + s.totalTimePrice;
      ordersTotal += s.totalOrdersPrice;
    }

    List<List<String>> data = [];
    double grandTotal = 0;
    totals.forEach((key, value) {
      data.add([key, '${value.toStringAsFixed(1)} جنيه']);
      grandTotal += value;
    });
    
    data.add(['المشاريب والطلبات', '${ordersTotal.toStringAsFixed(1)} جنيه']);
    grandTotal += ordersTotal;
    
    data.add(['----------------', '----------------']);
    data.add(['الإجمالي الكلي', '${grandTotal.toStringAsFixed(1)} جنيه']);

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: font, bold: font),
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('مقهى الألعاب - تقرير يوم ${DateFormat('yyyy-MM-dd').format(_selectedDate)}', style: pw.TextStyle(font: font, fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ['القسم', 'الإجمالي'],
                data: data,
                headerStyle: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold, fontSize: 18),
                cellStyle: pw.TextStyle(font: font, fontSize: 16),
                cellAlignment: pw.Alignment.centerRight,
              ),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/GameCafe_Report_${DateFormat('yyyy-MM-dd').format(_selectedDate)}.pdf');
    
    final fileBytes = await pdf.save();
    await file.writeAsBytes(fileBytes);
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم حفظ ملف PDF. جاري فتحه...'),
          duration: const Duration(seconds: 4),
        )
      );
    }
    
    if (Platform.isMacOS) {
      Process.run('open', [file.path]);
    } else if (Platform.isWindows) {
      Process.run('explorer.exe', [file.path]);
    }
  }
}
