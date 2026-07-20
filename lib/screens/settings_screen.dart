import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../models/device.dart';
import '../models/product.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الإعدادات'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_sweep, color: Colors.redAccent),
              tooltip: 'مسح السجل',
              onPressed: () async {
                String selectedCategory = 'الكل';
                final result = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: const Text('تأكيد مسح السجل', style: TextStyle(color: Colors.red)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('هل أنت متأكد من مسح السجل؟ لا يمكن التراجع عن هذا الإجراء.'),
                              const SizedBox(height: 16),
                              const Text('اختر الفئة:'),
                              DropdownButton<String>(
                                isExpanded: true,
                                dropdownColor: const Color(0xFF1E1E1E),
                                value: selectedCategory,
                                items: const [
                                  DropdownMenuItem(value: 'الكل', child: Text('الكل')),
                                  DropdownMenuItem(value: 'Billiards', child: Text('بلياردو')),
                                  DropdownMenuItem(value: 'Ping Pong', child: Text('بينج بونج')),
                                  DropdownMenuItem(value: 'PS1', child: Text('بلايستيشن ١')),
                                  DropdownMenuItem(value: 'PS2', child: Text('بلايستيشن ٢')),
                                  DropdownMenuItem(value: 'Direct', child: Text('مبيعات مباشرة (مشاريب)')),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedCategory = value;
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, null), child: const Text('إلغاء')),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              onPressed: () => Navigator.pop(context, selectedCategory),
                              child: const Text('تأكيد المسح', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      }
                    );
                  },
                );
                if (result != null) {
                  await ref.read(databaseServiceProvider).clearHistory(category: result);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم مسح السجل بنجاح!')));
                  }
                }
              },
            ),
          ],
          bottom: const TabBar(
            labelColor: Color(0xFFFFD700),
            unselectedLabelColor: Colors.white54,
            indicatorColor: Color(0xFFFFD700),
            tabs: [
              Tab(text: 'الأجهزة'),
              Tab(text: 'مقهى / أصناف'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DevicesTab(),
            ProductsTab(),
          ],
        ),
      ),
    );
  }
}

class DevicesTab extends ConsumerWidget {
  const DevicesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesAsync = ref.watch(devicesProvider);
    return Scaffold(
      body: devicesAsync.when(
        data: (devices) => ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final device = devices[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(device.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFD700))),
                subtitle: Text('${device.type} - الساعة: ${device.hourlyRate} جنيه | الجيم: ${device.matchRate ?? 0} جنيه'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showDeviceDialog(context, ref, device: device),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => ref.read(databaseServiceProvider).deleteDevice(device.id),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text('إضافة جهاز'),
        onPressed: () => _showDeviceDialog(context, ref),
      ),
    );
  }

  void _showDeviceDialog(BuildContext context, WidgetRef ref, {Device? device}) {
    showDialog(
      context: context,
      builder: (context) => DeviceDialog(device: device),
    );
  }
}

class ProductsTab extends ConsumerWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    return Scaffold(
      body: productsAsync.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFD700))),
                subtitle: Text('القسم: ${product.category}\nالسعر: ${product.price} جنيه | التكلفة: ${product.costPrice} جنيه | المخزون: ${product.stockCount}'),
                isThreeLine: true,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showProductDialog(context, ref, product: product),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => ref.read(databaseServiceProvider).deleteProduct(product.id),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text('إضافة صنف'),
        onPressed: () => _showProductDialog(context, ref),
      ),
    );
  }

  void _showProductDialog(BuildContext context, WidgetRef ref, {Product? product}) {
    showDialog(
      context: context,
      builder: (context) => ProductDialog(product: product),
    );
  }
}

// ---------------- DIALOGS ----------------

class DeviceDialog extends ConsumerStatefulWidget {
  final Device? device;
  const DeviceDialog({super.key, this.device});

  @override
  ConsumerState<DeviceDialog> createState() => _DeviceDialogState();
}

class _DeviceDialogState extends ConsumerState<DeviceDialog> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String type;
  late double hourlyRate;
  late double? matchRate;
  late double? multiplayerHourlyRate;

  @override
  void initState() {
    super.initState();
    name = widget.device?.name ?? '';
    type = widget.device?.type ?? 'Billiards';
    hourlyRate = widget.device?.hourlyRate ?? 0.0;
    matchRate = widget.device?.matchRate;
    multiplayerHourlyRate = widget.device?.multiplayerHourlyRate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.device == null ? 'إضافة جهاز جديد' : 'تعديل جهاز'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'اسم الجهاز'),
                validator: (val) => val == null || val.isEmpty ? 'مطلوب' : null,
                onSaved: (val) => name = val!,
              ),
              DropdownButtonFormField<String>(
                value: type,
                decoration: const InputDecoration(labelText: 'نوع الجهاز'),
                items: const [
                  DropdownMenuItem(value: 'Billiards', child: Text('بلياردو')),
                  DropdownMenuItem(value: 'Ping Pong', child: Text('بنج بونج')),
                  DropdownMenuItem(value: 'PS1', child: Text('بلايستيشن 1')),
                  DropdownMenuItem(value: 'PS2', child: Text('بلايستيشن 2')),
                  DropdownMenuItem(value: 'PS3', child: Text('بلايستيشن 3')),
                  DropdownMenuItem(value: 'PS4', child: Text('بلايستيشن 4')),
                  DropdownMenuItem(value: 'PS5', child: Text('بلايستيشن 5')),
                ],
                onChanged: (val) => setState(() => type = val!),
              ),
              TextFormField(
                initialValue: hourlyRate.toString(),
                decoration: const InputDecoration(labelText: 'سعر الساعة (فردي)'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || double.tryParse(val) == null ? 'رقم غير صحيح' : null,
                onSaved: (val) => hourlyRate = double.parse(val!),
              ),
              TextFormField(
                initialValue: multiplayerHourlyRate?.toString() ?? '',
                decoration: const InputDecoration(labelText: 'سعر الساعة (زوجي - إن وجد)'),
                keyboardType: TextInputType.number,
                onSaved: (val) => multiplayerHourlyRate = val != null && val.isNotEmpty ? double.tryParse(val) : null,
              ),
              TextFormField(
                initialValue: matchRate?.toString() ?? '',
                decoration: const InputDecoration(labelText: 'سعر الجيم / الماتش (إن وجد)'),
                keyboardType: TextInputType.number,
                onSaved: (val) => matchRate = val != null && val.isNotEmpty ? double.tryParse(val) : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), foregroundColor: Colors.black),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final device = widget.device ?? Device();
              device
                ..name = name
                ..type = type
                ..hourlyRate = hourlyRate
                ..matchRate = matchRate
                ..multiplayerHourlyRate = multiplayerHourlyRate;
              await ref.read(databaseServiceProvider).saveDevice(device);
              if (mounted) Navigator.pop(context);
            }
          },
          child: const Text('حفظ'),
        ),
      ],
    );
  }
}

class ProductDialog extends ConsumerStatefulWidget {
  final Product? product;
  const ProductDialog({super.key, this.product});

  @override
  ConsumerState<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends ConsumerState<ProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String category;
  late double price;
  late double costPrice;
  late int stockCount;

  @override
  void initState() {
    super.initState();
    name = widget.product?.name ?? '';
    category = widget.product?.category ?? 'Drink';
    price = widget.product?.price ?? 0.0;
    costPrice = widget.product?.costPrice ?? 0.0;
    stockCount = widget.product?.stockCount ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'إضافة صنف جديد' : 'تعديل صنف'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'اسم الصنف'),
                validator: (val) => val == null || val.isEmpty ? 'مطلوب' : null,
                onSaved: (val) => name = val!,
              ),
              DropdownButtonFormField<String>(
                value: category,
                decoration: const InputDecoration(labelText: 'القسم'),
                items: const [
                  DropdownMenuItem(value: 'Drink', child: Text('مشروبات')),
                  DropdownMenuItem(value: 'Food', child: Text('مأكولات/تسالي')),
                  DropdownMenuItem(value: 'Other', child: Text('أخرى')),
                ],
                onChanged: (val) => setState(() => category = val!),
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: const InputDecoration(labelText: 'سعر البيع'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || double.tryParse(val) == null ? 'رقم غير صحيح' : null,
                onSaved: (val) => price = double.parse(val!),
              ),

              TextFormField(
                initialValue: stockCount.toString(),
                decoration: const InputDecoration(labelText: 'المخزون الحالي'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || int.tryParse(val) == null ? 'رقم صحيح مطلوب' : null,
                onSaved: (val) => stockCount = int.parse(val!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700), foregroundColor: Colors.black),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final product = widget.product ?? Product();
              product
                ..name = name
                ..category = category
                ..price = price
                ..costPrice = costPrice
                ..stockCount = stockCount;
              await ref.read(databaseServiceProvider).saveProduct(product);
              if (mounted) Navigator.pop(context);
            }
          },
          child: const Text('حفظ'),
        ),
      ],
    );
  }
}
