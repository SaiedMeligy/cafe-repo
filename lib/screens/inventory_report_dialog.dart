import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/providers.dart';

class InventoryReportDialog extends ConsumerStatefulWidget {
  const InventoryReportDialog({super.key});

  @override
  ConsumerState<InventoryReportDialog> createState() => _InventoryReportDialogState();
}

class _InventoryReportDialogState extends ConsumerState<InventoryReportDialog> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);
    final sessionsAsync = ref.watch(completedSessionsProvider);

    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('جرد المخزن', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
          TextButton.icon(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            label: Text(
              DateFormat('yyyy-MM-dd').format(_selectedDate),
              style: const TextStyle(color: Colors.white),
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
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 500,
        child: productsAsync.when(
          data: (products) {
            return sessionsAsync.when(
              data: (sessions) {
                // Calculate sold quantities for the selected date
                final Map<int, int> soldQuantities = {};
                final Map<int, double> soldValues = {};
                
                final filteredSessions = sessions.where((s) {
                  return s.startTime.year == _selectedDate.year &&
                         s.startTime.month == _selectedDate.month &&
                         s.startTime.day == _selectedDate.day;
                });

                for (var session in filteredSessions) {
                  for (var order in session.orders) {
                    soldQuantities[order.productId] = (soldQuantities[order.productId] ?? 0) + order.quantity;
                    soldValues[order.productId] = (soldValues[order.productId] ?? 0.0) + order.total;
                  }
                }

                if (products.isEmpty) {
                  return const Center(child: Text('لا توجد أصناف في المخزن', style: TextStyle(color: Colors.white)));
                }
                
                double totalSalesValue = 0;
                for (var v in soldValues.values) {
                  totalSalesValue += v;
                }

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor: WidgetStateProperty.all(const Color(0xFF2A2A2A)),
                            dataTextStyle: const TextStyle(color: Colors.white),
                            headingTextStyle: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
                            columns: const [
                              DataColumn(label: Text('الصنف')),
                              DataColumn(label: Text('المباع اليوم')),
                              DataColumn(label: Text('قيمة المبيعات')),
                              DataColumn(label: Text('المتبقي (المخزون)')),
                            ],
                            rows: products.map((product) {
                              final soldQty = soldQuantities[product.id] ?? 0;
                              final soldVal = soldValues[product.id] ?? 0.0;
                              
                              return DataRow(cells: [
                                DataCell(Text(product.name)),
                                DataCell(Text('$soldQty', style: TextStyle(color: soldQty > 0 ? Colors.greenAccent : Colors.white))),
                                DataCell(Text('${soldVal.toStringAsFixed(1)} جنيه')),
                                DataCell(Text('${product.stockCount}', style: TextStyle(color: product.stockCount < 10 ? Colors.redAccent : Colors.white, fontWeight: FontWeight.bold))),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white24),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('إجمالي مبيعات الأصناف:', style: TextStyle(fontSize: 18, color: Colors.white)),
                          Text('${totalSalesValue.toStringAsFixed(1)} جنيه', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إغلاق', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
