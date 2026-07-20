import 'package:isar/isar.dart';
import '../models/device.dart';
import '../models/product.dart';
import '../models/session.dart';

class DatabaseService {
  final Isar isar;

  DatabaseService(this.isar);

  Future<void> checkAndSeedData() async {
    final count = await isar.devices.count();
    if (count == 0) {
      // Exact requested Devices
      final devices = [
        Device()..name = 'بلياردو 1'..type = 'Billiards'..hourlyRate = 60..matchRate = 5,
        Device()..name = 'بلياردو 2'..type = 'Billiards'..hourlyRate = 60..matchRate = 5,
        Device()..name = 'بينج بونج'..type = 'Ping Pong'..hourlyRate = 60..matchRate = 5,
        Device()..name = 'بلايستشين ١'..type = 'PS1'..hourlyRate = 50..matchRate = 15,
        Device()..name = 'بلايستيشن ٢'..type = 'PS2'..hourlyRate = 40..matchRate = 10,
      ];

      // Exact requested Products
      final products = [
        Product()..name = 'إندومي صغير'..price = 10..costPrice = 7..stockCount = 100..category = 'Food',
        Product()..name = 'إندومي كبير'..price = 15..costPrice = 10..stockCount = 100..category = 'Food',
        Product()..name = 'بيبسي'..price = 15..costPrice = 12..stockCount = 100..category = 'Drink',
        Product()..name = 'فيوري'..price = 15..costPrice = 12..stockCount = 100..category = 'Drink',
        Product()..name = 'عصير'..price = 10..costPrice = 8..stockCount = 100..category = 'Drink',
        Product()..name = 'استنج'..price = 15..costPrice = 12..stockCount = 100..category = 'Drink',
        Product()..name = 'كوفي ميكس'..price = 20..costPrice = 15..stockCount = 100..category = 'Drink',
        Product()..name = 'نسكافيه'..price = 20..costPrice = 15..stockCount = 100..category = 'Drink',
        Product()..name = 'كابتشينو'..price = 20..costPrice = 15..stockCount = 100..category = 'Drink',
        Product()..name = 'قهوه'..price = 20..costPrice = 10..stockCount = 100..category = 'Drink',
        Product()..name = 'شاي'..price = 10..costPrice = 5..stockCount = 100..category = 'Drink',
        Product()..name = 'ينسون'..price = 10..costPrice = 5..stockCount = 100..category = 'Drink',
      ];

      await isar.writeTxn(() async {
        await isar.devices.putAll(devices);
        await isar.products.putAll(products);
      });
    }
  }

  // --- Devices ---
  Stream<List<Device>> watchDevices() {
    return isar.devices.where().watch(fireImmediately: true);
  }

  Future<void> saveDevice(Device device) async {
    await isar.writeTxn(() async {
      await isar.devices.put(device);
    });
  }

  Future<void> deleteDevice(int id) async {
    await isar.writeTxn(() async {
      await isar.devices.delete(id);
    });
  }

  // --- Products ---
  Stream<List<Product>> watchProducts() {
    return isar.products.where().watch(fireImmediately: true);
  }

  Future<void> saveProduct(Product product) async {
    await isar.writeTxn(() async {
      await isar.products.put(product);
    });
  }

  Future<void> deleteProduct(int id) async {
    await isar.writeTxn(() async {
      await isar.products.delete(id);
    });
  }

  // --- Sessions ---
  Stream<List<PlaySession>> watchActiveSessions() {
    return isar.playSessions.filter().isCompletedEqualTo(false).watch(fireImmediately: true);
  }

  Stream<List<PlaySession>> watchCompletedSessions() {
    return isar.playSessions.filter().isCompletedEqualTo(true).sortByEndTimeDesc().watch(fireImmediately: true);
  }

  Future<void> saveSession(PlaySession session) async {
    await isar.writeTxn(() async {
      await isar.playSessions.put(session);
      await session.device.save();
    });
  }

  Future<void> completeSession(PlaySession session) async {
    session.isCompleted = true;
    session.endTime = DateTime.now();
    await isar.writeTxn(() async {
      await isar.playSessions.put(session);
      await session.device.save();
      
      // Deduct stock for products ordered
      for (var order in session.orders) {
        final product = await isar.products.get(order.productId);
        if (product != null) {
          product.stockCount -= order.quantity;
          if (product.stockCount < 0) product.stockCount = 0;
          await isar.products.put(product);
        }
      }
    });
  }

  Future<void> clearHistory({String? category}) async {
    await isar.writeTxn(() async {
      final completedSessions = await isar.playSessions.filter().isCompletedEqualTo(true).findAll();
      for (var session in completedSessions) {
        if (category == null || category == 'الكل') {
          await isar.playSessions.delete(session.id);
        } else if (category == 'Direct') {
          if (session.device.value == null) {
            await isar.playSessions.delete(session.id);
          }
        } else {
          if (session.device.value?.type == category) {
            await isar.playSessions.delete(session.id);
          }
        }
      }
    });
  }
}

