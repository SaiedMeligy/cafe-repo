import 'package:isar/isar.dart';

part 'direct_cart_item.g.dart';

@collection
class DirectCartItem {
  Id id = Isar.autoIncrement;
  
  late int productId;
  late String productName;
  late double price;
  late double costPrice;
  int quantity = 1;

  double get total => price * quantity;
}
