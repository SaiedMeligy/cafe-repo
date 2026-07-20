import 'package:isar/isar.dart';

part 'daily_report.g.dart';

@collection
class DailyReport {
  Id id = Isar.autoIncrement;

  late DateTime date;

  double totalTimeIncome = 0.0;
  double totalOrdersIncome = 0.0;
  double totalOrdersCost = 0.0;
  
  double get totalIncome => totalTimeIncome + totalOrdersIncome;
  double get totalProfit => totalTimeIncome + (totalOrdersIncome - totalOrdersCost);

  int totalSessions = 0;
}
