import 'package:isar/isar.dart';
import 'device.dart';

part 'session.g.dart';

@embedded
class SessionOrder {
  late int productId;
  late String productName;
  late double price;
  late double costPrice;
  late int quantity;
  
  double get total => price * quantity;
  double get totalCost => costPrice * quantity;
}

@collection
class PlaySession {
  Id id = Isar.autoIncrement;

  final device = IsarLink<Device>();

  DateTime startTime = DateTime.now();
  DateTime? endTime;

  bool isMultiplayer = false;
  bool isMatchMode = false;
  
  /// In match mode, this is how many matches are played
  int matchesCount = 0;

  /// Expected duration in minutes (null for open session)
  int? expectedDurationMinutes;

  List<SessionOrder> orders = [];

  bool isCompleted = false;

  /// Calculated when session is completed
  double totalTimePrice = 0.0;
  double totalOrdersPrice = 0.0;
  double get grandTotal => totalTimePrice + totalOrdersPrice;

  /// 'Paid' or 'Deferred' (آجل)
  String paymentStatus = 'Paid';
}
