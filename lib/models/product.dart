import 'package:isar/isar.dart';

part 'product.g.dart';

@collection
class Product {
  Id id = Isar.autoIncrement;

  late String name;

  late double price;
  late double costPrice;

  int stockCount = 0;

  String category = 'other';
}
