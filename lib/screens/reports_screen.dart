import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:isar/isar.dart';
import '../providers/providers.dart';
import '../models/session.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(activeSessionsProvider); // We should ideally fetch completed sessions for the day, but let's just use a provider for all completed sessions or fetch manually.
    
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
            ElevatedButton.icon(
              icon: const Icon(Icons.table_view),
              label: const Text('تصدير إلى إكسيل'),
              onPressed: () => _exportToExcel(context, ref),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('تصدير إلى PDF'),
              onPressed: () => _exportToPdf(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportToExcel(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;
    final allSessions = await isar.playSessions.where().findAll();
    
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

    for (var s in allSessions) {
      sheetObject.appendRow([
        s.id.toString(),
        s.device.value?.name ?? 'غير معروف',
        s.startTime.toString(),
        s.endTime?.toString() ?? 'شغال',
        s.totalTimePrice.toString(),
        s.totalOrdersPrice.toString(),
        s.grandTotal.toString(),
      ]);
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/GameCafe_Report_${DateTime.now().millisecondsSinceEpoch}.xlsx');
    
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

  Future<void> _exportToPdf(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseServiceProvider);
    final isar = db.isar;
    final allSessions = await isar.playSessions.where().findAll();

    final pdf = pw.Document();
    final font = await PdfGoogleFonts.cairoRegular();

    Map<String, double> totals = {};
    double ordersTotal = 0;
    
    for (var s in allSessions) {
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
    
    // Add empty row for spacing
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
              pw.Text('مقهى الألعاب - تقرير ملخص', style: pw.TextStyle(font: font, fontSize: 24, fontWeight: pw.FontWeight.bold)),
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

    // Use Printing to show print/save dialog
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'GameCafe_Report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }
}
