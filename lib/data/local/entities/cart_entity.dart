import 'package:floor/floor.dart';
import 'package:flutter_app/domain/models/cart.dart';

@Entity(tableName: 'carts')
class CartEntity {
  @PrimaryKey(autoGenerate: false)
  final String id;
  final String userId;
  final Map<String, dynamic> items;
  final String total;

  CartEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
  });

  Cart toCart() {
    return Cart(
      id: id,
      userId: userId,
      items: items,
      total: total,
    );
  }
}
