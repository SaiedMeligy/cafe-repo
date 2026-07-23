import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../providers/providers.dart';
import '../models/device.dart';
import '../models/session.dart';
import '../models/product.dart';

class SessionScreen extends ConsumerStatefulWidget {
  final Device device;
  final PlaySession? existingSession;

  const SessionScreen({super.key, required this.device, this.existingSession});

  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  late PlaySession _session;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.existingSession != null) {
      _session = widget.existingSession!;
      _startTimer();
    } else {
      _session = PlaySession()
        ..device.value = widget.device
        ..startTime = DateTime.now();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startNewSession() async {
    final db = ref.read(databaseServiceProvider);
    await db.saveSession(_session);
    _startTimer();
    setState(() {});
  }

  void _endSession(String paymentStatus) async {
    final db = ref.read(databaseServiceProvider);
    
    _session.paymentStatus = paymentStatus;
    
    // Calculate final time price
    if (!_session.isMatchMode) {
      final actualSeconds = DateTime.now().difference(_session.startTime).inSeconds;
      int billableSeconds = actualSeconds;
      if (_session.expectedDurationMinutes != null) {
        final expectedSeconds = _session.expectedDurationMinutes! * 60;
        if (expectedSeconds > actualSeconds) {
          billableSeconds = expectedSeconds;
        }
      }
      final hours = billableSeconds / 3600.0;
      final rate = _session.isMultiplayer ? (widget.device.multiplayerHourlyRate ?? widget.device.hourlyRate) : widget.device.hourlyRate;
      _session.totalTimePrice = hours * rate;
    } else {
      final matchRate = _session.isMultiplayer ? (widget.device.multiplayerMatchRate ?? widget.device.matchRate ?? 0) : (widget.device.matchRate ?? 0);
      _session.totalTimePrice = (_session.matchesCount * matchRate).toDouble();
    }

    // Calculate orders price
    _session.totalOrdersPrice = _session.orders.fold(0, (sum, item) => sum + item.total);

    await db.completeSession(_session);
    
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _addProduct(Product product) async {
    setState(() {
      final newOrders = List<SessionOrder>.from(_session.orders);
      final existingIndex = newOrders.indexWhere((o) => o.productId == product.id);
      if (existingIndex >= 0) {
        newOrders[existingIndex].quantity++;
      } else {
        newOrders.add(SessionOrder()
          ..productId = product.id
          ..productName = product.name
          ..price = product.price
          ..costPrice = product.costPrice
          ..quantity = 1);
      }
      _session.orders = newOrders;
    });
    final db = ref.read(databaseServiceProvider);
    await db.saveSession(_session);
    await db.adjustProductStock(product.id, -1);
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = _session.id != Isar.autoIncrement;

    final duration = DateTime.now().difference(_session.startTime);
    final String timeStr = '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    final currentRate = _session.isMultiplayer ? (widget.device.multiplayerHourlyRate ?? widget.device.hourlyRate) : widget.device.hourlyRate;

    return Scaffold(
      appBar: AppBar(
        title: Text('جلسة - ${widget.device.name}'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الحالة: ${isRunning ? "شغال" : "لم يبدأ"}', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  
                  if (!isRunning) ...[
                    SwitchListTile(
                      title: const Text('لعب زوجي'),
                      value: _session.isMultiplayer,
                      onChanged: (val) => setState(() => _session.isMultiplayer = val),
                    ),
                    SwitchListTile(
                      title: const Text('نظام الجيم (بدون وقت)'),
                      value: _session.isMatchMode,
                      onChanged: (val) => setState(() {
                        _session.isMatchMode = val;
                        if (val) _session.expectedDurationMinutes = null;
                      }),
                    ),
                    if (!_session.isMatchMode)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: DropdownButtonFormField<int?>(
                          decoration: const InputDecoration(
                            labelText: 'مدة الجلسة (اختياري)',
                            border: OutlineInputBorder(),
                          ),
                          value: _session.expectedDurationMinutes,
                          items: [
                            const DropdownMenuItem(value: null, child: Text('مفتوح (بدون وقت محدد)')),
                            DropdownMenuItem(value: 30, child: Text('نصف ساعة - ${(currentRate * 0.5).toStringAsFixed(1)} جنيه')),
                            DropdownMenuItem(value: 60, child: Text('ساعة واحدة - ${currentRate.toStringAsFixed(1)} جنيه')),
                            DropdownMenuItem(value: 90, child: Text('ساعة ونصف - ${(currentRate * 1.5).toStringAsFixed(1)} جنيه')),
                            DropdownMenuItem(value: 120, child: Text('ساعتين - ${(currentRate * 2.0).toStringAsFixed(1)} جنيه')),
                            DropdownMenuItem(value: 180, child: Text('3 ساعات - ${(currentRate * 3.0).toStringAsFixed(1)} جنيه')),
                          ],
                          onChanged: (val) => setState(() => _session.expectedDurationMinutes = val),
                        ),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _startNewSession,
                      child: const Text('بدء الجلسة'),
                    ),
                  ] else ...[
                    if (!_session.isMatchMode)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الوقت: $timeStr', style: TextStyle(
                            fontSize: 48, 
                            fontWeight: FontWeight.bold,
                            color: _session.expectedDurationMinutes != null && duration.inMinutes >= _session.expectedDurationMinutes! ? Colors.redAccent : Colors.white,
                          )),
                          Text('تكلفة الوقت الحالي: ${((duration.inMinutes / 60) * currentRate).toStringAsFixed(1)} جنيه', style: const TextStyle(fontSize: 18, color: Colors.greenAccent)),
                          if (_session.expectedDurationMinutes != null)
                            Text('المدة المحددة: ${_session.expectedDurationMinutes! >= 60 ? "${_session.expectedDurationMinutes! ~/ 60} ساعة" : ""} ${_session.expectedDurationMinutes! % 60 != 0 ? "${_session.expectedDurationMinutes! % 60} دقيقة" : ""}'.trim() + ' (${(_session.expectedDurationMinutes! / 60 * currentRate).toStringAsFixed(1)} جنيه)', 
                                style: const TextStyle(fontSize: 18, color: Color(0xFFFFD700))),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('المباريات: ', style: TextStyle(fontSize: 24)),
                              IconButton(icon: const Icon(Icons.remove), onPressed: () async {
                                setState(() => _session.matchesCount = (_session.matchesCount > 0 ? _session.matchesCount - 1 : 0));
                                if (_session.id != Isar.autoIncrement) {
                                  await ref.read(databaseServiceProvider).saveSession(_session);
                                }
                              }),
                              Text('${_session.matchesCount}', style: const TextStyle(fontSize: 24)),
                              IconButton(icon: const Icon(Icons.add), onPressed: () async {
                                setState(() => _session.matchesCount++);
                                if (_session.id != Isar.autoIncrement) {
                                  await ref.read(databaseServiceProvider).saveSession(_session);
                                }
                              }),
                            ],
                          ),
                          Text('تكلفة المباريات: ${(_session.matchesCount * (_session.isMultiplayer ? (widget.device.multiplayerMatchRate ?? widget.device.matchRate ?? 0) : (widget.device.matchRate ?? 0))).toStringAsFixed(1)} جنيه', style: const TextStyle(fontSize: 18, color: Colors.greenAccent)),
                        ],
                      ),
                    
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('الطلبات:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('الإجمالي: ${_session.orders.fold(0.0, (sum, item) => sum + item.total).toStringAsFixed(1)} جنيه', style: const TextStyle(fontSize: 18, color: Colors.greenAccent)),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _session.orders.length,
                        itemBuilder: (context, index) {
                          final order = _session.orders[index];
                          return ListTile(
                            title: Text(order.productName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            subtitle: Text('${order.price} EGP x ${order.quantity}', style: const TextStyle(fontSize: 16)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${order.total} EGP', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                                  onPressed: () async {
                                    setState(() {
                                      final newOrders = List<SessionOrder>.from(_session.orders);
                                      if (newOrders[index].quantity > 1) {
                                        newOrders[index].quantity--;
                                      } else {
                                        newOrders.removeAt(index);
                                      }
                                      _session.orders = newOrders;
                                    });
                                    final db = ref.read(databaseServiceProvider);
                                    await db.saveSession(_session);
                                    await db.adjustProductStock(order.productId, 1);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.blueGrey.shade900, borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('الإجمالي الكلي:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          Text(
                            '${(_session.isMatchMode ? (_session.matchesCount * (_session.isMultiplayer ? (widget.device.multiplayerMatchRate ?? widget.device.matchRate ?? 0) : (widget.device.matchRate ?? 0))) : ((duration.inMinutes / 60) * currentRate) + _session.orders.fold(0.0, (sum, item) => sum + item.total)).toStringAsFixed(1)} جنيه',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFFD700))
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () => _endSession('Paid'),
                            icon: const Icon(Icons.stop),
                            label: const Text('إنهاء ودفع', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: () => _endSession('Deferred'),
                            icon: const Icon(Icons.pause_circle_filled),
                            label: const Text('إنهاء آجل', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ),
          
          if (isRunning)
            const VerticalDivider(width: 1),
          if (isRunning)
            Expanded(
              flex: 1,
              child: _ProductsGrid(onProductSelect: _addProduct),
            ),
        ],
      ),
    );
  }
}

class _ProductsGrid extends ConsumerWidget {
  final Function(Product) onProductSelect;

  const _ProductsGrid({required this.onProductSelect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    
    return productsAsync.when(
      data: (products) => GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return InkWell(
            onTap: () => onProductSelect(product),
            child: Card(
              color: Colors.blueGrey.shade800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(product.name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                  Text('${product.price} EGP', style: const TextStyle(color: Colors.greenAccent)),
                ],
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
