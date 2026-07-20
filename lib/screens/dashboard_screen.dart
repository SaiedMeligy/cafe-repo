import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/providers.dart';
import '../models/device.dart';
import '../models/session.dart';
import '../models/product.dart';
import 'settings_screen.dart';
import 'reports_screen.dart';
import 'session_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Row(
        children: [
          // Content
          Expanded(
            child: _buildContent(),
          ),
          // Sidebar (Right side because of RTL)
          NavigationRail(
            backgroundColor: const Color(0xFF111111),
            selectedIndex: _selectedIndex,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  const Icon(Icons.gamepad, size: 40, color: Color(0xFFFFD700)),
                  const SizedBox(height: 8),
                  const Text(
                    'الغندور',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                ],
              ),
            ),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIconTheme: const IconThemeData(color: Color(0xFFFFD700), size: 32),
            unselectedIconTheme: const IconThemeData(color: Colors.white54, size: 24),
            selectedLabelTextStyle: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
            unselectedLabelTextStyle: const TextStyle(color: Colors.white54),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.sports_baseball), // Close enough for billiards
                label: Text('بلياردو'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.sports_tennis),
                label: Text('بنج بونج'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.videogame_asset),
                label: Text('بلايستيشن'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.local_cafe),
                label: Text('مشاريب'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.analytics),
                label: Text('التقارير'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('الإعدادات'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const DevicesView(deviceCategory: 'Billiards');
      case 1:
        return const DevicesView(deviceCategory: 'Ping Pong');
      case 2:
        return const DevicesView(deviceCategory: 'PS');
      case 3:
        return const ProductsView();
      case 4:
        return const ReportsScreen();
      case 5:
        return const SettingsScreen();
      default:
        return const Center(child: Text('Not Implemented'));
    }
  }
}

class DevicesView extends ConsumerWidget {
  final String deviceCategory;
  
  const DevicesView({super.key, required this.deviceCategory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesAsync = ref.watch(devicesProvider);
    final sessionsAsync = ref.watch(activeSessionsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        elevation: 0,
        title: Text(
          deviceCategory == 'Billiards' ? 'قسم البلياردو' :
          deviceCategory == 'Ping Pong' ? 'قسم البنج بونج' :
          'قسم البلايستيشن'
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: devicesAsync.when(
              data: (devices) {
                final filteredDevices = devices.where((d) => d.type.startsWith(deviceCategory)).toList();
                
                if (filteredDevices.isEmpty) {
                  return const Center(child: Text('لا يوجد أجهزة في هذا القسم.'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: filteredDevices.length,
                  itemBuilder: (context, index) {
                    final device = filteredDevices[index];
                    
                    PlaySession? activeSession;
                    if (sessionsAsync is AsyncData) {
                      activeSession = sessionsAsync.value!.where((s) => s.device.value?.id == device.id).firstOrNull;
                    }

                    final isFree = activeSession == null;

                    return Card(
                      elevation: isFree ? 4 : 12,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isFree ? Colors.transparent : const Color(0xFFFFD700),
                          width: isFree ? 0 : 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: isFree ? const Color(0xFF1E1E1E) : const Color(0xFF2A2A2A),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      device.type == 'PS1' ? 'assets/images/ps1.jpg' :
                                      device.type == 'PS2' ? 'assets/images/ps2.jpg' :
                                      device.type.startsWith('Ping Pong') ? 'assets/images/ping_pong.jpg' :
                                      'assets/images/billiards.jpg'
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: isFree ? const ColorFilter.mode(Colors.black54, BlendMode.darken) : null,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(device.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            if (isFree)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFD700),
                                  foregroundColor: Colors.black,
                                  minimumSize: const Size(double.infinity, 45),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SessionScreen(device: device)));
                                },
                                child: const Text('بدء الجلسة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              )
                            else
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFD700).withAlpha(51),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Text(
                                      'شغال - ${activeSession.isMultiplayer ? "زوجي" : "فردي"}',
                                      style: const TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF333333),
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(double.infinity, 45),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => SessionScreen(device: device, existingSession: activeSession)));
                                    },
                                    child: const Text('إدارة الجلسة'),
                                  )
                                ],
                              )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          const Divider(height: 1, color: Colors.white24),
          Expanded(
            flex: 2,
            child: CategoryHistoryTable(deviceCategory: deviceCategory),
          )
        ],
      ),
    );
  }
}

class CategoryHistoryTable extends ConsumerStatefulWidget {
  final String deviceCategory;
  const CategoryHistoryTable({super.key, required this.deviceCategory});

  @override
  ConsumerState<CategoryHistoryTable> createState() => _CategoryHistoryTableState();
}

class _CategoryHistoryTableState extends ConsumerState<CategoryHistoryTable> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final completedSessionsAsync = ref.watch(completedSessionsProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'سجل العمليات السابقة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
              ),
              TextButton.icon(
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                label: Text(
                  _selectedDate == null 
                    ? 'تصفية بالتاريخ' 
                    : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
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
          const SizedBox(height: 16),
          Expanded(
            child: completedSessionsAsync.when(
              data: (sessions) {
                // Filter sessions by category and date
                final filtered = sessions.where((s) {
                  final categoryMatch = s.device.value?.type.startsWith(widget.deviceCategory) ?? false;
                  if (!categoryMatch) return false;
                  if (_selectedDate == null) return true;
                  final endDate = s.endTime;
                  if (endDate == null) return false;
                  return endDate.year == _selectedDate!.year &&
                         endDate.month == _selectedDate!.month &&
                         endDate.day == _selectedDate!.day;
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('لا توجد عمليات سابقة لهذا التاريخ.'));
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: constraints.maxWidth),
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.all(const Color(0xFF1E1E1E)),
                          columns: const [
                      DataColumn(label: Text('الجهاز')),
                      DataColumn(label: Text('البداية')),
                      DataColumn(label: Text('النهاية')),
                      DataColumn(label: Text('النظام')),
                      DataColumn(label: Text('الطلبات (جنيه)')),
                      DataColumn(label: Text('اللعب (جنيه)')),
                      DataColumn(label: Text('الإجمالي')),
                      DataColumn(label: Text('تفاصيل')),
                    ],
                    rows: filtered.map((session) {
                      final timeFormat = DateFormat('hh:mm a');
                      return DataRow(
                        cells: [
                          DataCell(Text(session.device.value?.name ?? 'محذوف')),
                          DataCell(Text(timeFormat.format(session.startTime))),
                          DataCell(Text(session.endTime != null ? timeFormat.format(session.endTime!) : '-')),
                          DataCell(Text(session.isMatchMode ? 'جيم' : 'وقت')),
                          DataCell(Text('${session.totalOrdersPrice}')),
                          DataCell(Text('${session.totalTimePrice.toStringAsFixed(1)}')),
                          DataCell(Text(
                            '${(session.totalOrdersPrice + session.totalTimePrice).toStringAsFixed(1)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
                          )),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.info_outline, color: Colors.blueAccent),
                              tooltip: 'عرض التفاصيل',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    final duration = session.endTime != null ? session.endTime!.difference(session.startTime) : Duration.zero;
                                    final ordersText = session.orders.map((o) => '${o.productName} (العدد: ${o.quantity}) - ${o.total} جنيه').join('\n');
                                    
                                    return AlertDialog(
                                      title: Text('تفاصيل جلسة - ${session.device.value?.name ?? 'غير معروف'}', style: const TextStyle(color: Color(0xFFFFD700))),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text('وقت البداية: ${timeFormat.format(session.startTime)}'),
                                            if (session.endTime != null) Text('وقت النهاية: ${timeFormat.format(session.endTime!)}'),
                                            Text('مدة اللعب: ${duration.inHours} ساعة و ${duration.inMinutes % 60} دقيقة'),
                                            Text('نظام اللعب: ${session.isMatchMode ? "بالماتش (${session.matchesCount} ماتش)" : "بالوقت"}'),
                                            Text('حالة الدفع: ${session.paymentStatus == "Paid" ? "تم الدفع ✓" : "آجل (عليه فلوس) ⏳"}', style: TextStyle(color: session.paymentStatus == "Paid" ? Colors.green : Colors.orange, fontWeight: FontWeight.bold)),
                                            const Divider(),
                                            const Text('تكلفة اللعب:', style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text('${session.totalTimePrice.toStringAsFixed(1)} جنيه'),
                                            const SizedBox(height: 10),
                                            const Text('الطلبات (المشاريب/المأكولات):', style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text(ordersText.isEmpty ? 'لا توجد طلبات' : ordersText),
                                            const SizedBox(height: 5),
                                            Text('إجمالي الطلبات: ${session.totalOrdersPrice.toStringAsFixed(1)} جنيه', style: const TextStyle(color: Colors.grey)),
                                            const Divider(),
                                            Text('الإجمالي الكلي: ${(session.totalTimePrice + session.totalOrdersPrice).toStringAsFixed(1)} جنيه', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('إغلاق'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                      ]);
                    }).toList()
                      ..add(
                        DataRow(
                          color: MaterialStateProperty.all(const Color(0xFF2E2E2E)),
                          cells: [
                            const DataCell(Text('الإجمالي الكلي', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFD700)))),
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            const DataCell(Text('')),
                            DataCell(Text(filtered.fold(0.0, (sum, s) => sum + s.totalOrdersPrice).toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                            DataCell(Text(filtered.fold(0.0, (sum, s) => sum + s.totalTimePrice).toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                            DataCell(Text(
                              filtered.fold(0.0, (sum, s) => sum + s.totalOrdersPrice + s.totalTimePrice).toStringAsFixed(1),
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
                            )),
                            const DataCell(Text('')),
                          ],
                        ),
                      ),
                  ),
                ),
              );
            }
          );
        },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          )
        ],
      ),
    );
  }
}

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        elevation: 0,
        title: const Text('المشاريب والأصناف (المخزون)'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: productsAsync.when(
              data: (products) {
                if (products.isEmpty) {
                  return const Center(child: Text('لا يوجد أصناف.'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/drinks.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 8),
                            Text('${product.price} جنيه', style: const TextStyle(color: Color(0xFFFFD700), fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('المخزون: ${product.stockCount}', style: const TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          const Divider(height: 1, color: Colors.white24),
          const Expanded(
            flex: 2,
            child: ProductsHistoryTable(),
          )
        ],
      ),
    );
  }
}

class ProductsHistoryTable extends ConsumerWidget {
  const ProductsHistoryTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedSessionsAsync = ref.watch(completedSessionsProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'سجل مبيعات الأصناف من الجلسات',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: completedSessionsAsync.when(
              data: (sessions) {
                // Filter sessions that have orders
                final filtered = sessions.where((s) => s.orders.isNotEmpty).toList();
                if (filtered.isEmpty) {
                  return const Center(child: Text('لا توجد مبيعات أصناف سابقة اليوم.'));
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: constraints.maxWidth),
                        child: DataTable(
                          headingRowColor: MaterialStateProperty.all(const Color(0xFF1E1E1E)),
                          columns: const [
                            DataColumn(label: Text('الجهاز / الطلب')),
                            DataColumn(label: Text('الأصناف')),
                            DataColumn(label: Text('الوقت')),
                            DataColumn(label: Text('الإجمالي (جنيه)')),
                          ],
                          rows: filtered.map((session) {
                            final timeFormat = DateFormat('hh:mm a');
                            final itemsSummary = session.orders.map((o) => '${o.productName} (x${o.quantity})').join(', ');
                            return DataRow(
                              cells: [
                                DataCell(Text(session.device.value?.name ?? 'مباشر')),
                                DataCell(Text(itemsSummary)),
                                DataCell(Text(session.endTime != null ? timeFormat.format(session.endTime!) : '-')),
                                DataCell(Text(
                                  '${session.totalOrdersPrice.toStringAsFixed(1)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
                                )),
                              ]
                            );
                          }).toList()
                            ..add(
                              DataRow(
                                color: MaterialStateProperty.all(const Color(0xFF2E2E2E)),
                                cells: [
                                  const DataCell(Text('الإجمالي الكلي', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFD700)))),
                                  const DataCell(Text('')),
                                  const DataCell(Text('')),
                                  DataCell(Text(
                                    filtered.fold(0.0, (sum, s) => sum + s.totalOrdersPrice).toStringAsFixed(1),
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
                                  )),
                                ],
                              ),
                            ),
                        ),
                      ),
                    );
                  }
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          )
        ],
      ),
    );
  }
}
