import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/device.dart';
import '../models/product.dart';
import '../models/session.dart';
import '../models/direct_cart_item.dart';
import '../services/database_service.dart';
import '../main.dart'; // for isarProvider

final databaseServiceProvider = Provider<DatabaseService>((ref) {
  final isar = ref.watch(isarProvider);
  return DatabaseService(isar);
});

final devicesProvider = StreamProvider<List<Device>>((ref) {
  return ref.watch(databaseServiceProvider).watchDevices();
});

final productsProvider = StreamProvider<List<Product>>((ref) {
  return ref.watch(databaseServiceProvider).watchProducts();
});

final activeSessionsProvider = StreamProvider<List<PlaySession>>((ref) {
  return ref.watch(databaseServiceProvider).watchActiveSessions();
});

final completedSessionsProvider = StreamProvider<List<PlaySession>>((ref) {
  return ref.watch(databaseServiceProvider).watchCompletedSessions();
});

final directCartProvider = StreamProvider<List<DirectCartItem>>((ref) {
  return ref.watch(databaseServiceProvider).watchDirectCart();
});
