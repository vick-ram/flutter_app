import 'package:floor/floor.dart';
import 'package:flutter_app/domain/models/cart_item.dart';

@Entity(tableName: 'cart_items')
class CartItemEntity {
  @PrimaryKey(autoGenerate: false)
  final String id;
  final String cartId;
  final Map<String, dynamic> product;
  final int quantity;
  final String unitPrice;
  final String discountedPrice;

  CartItemEntity({
    required this.id,
    required this.cartId,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.discountedPrice,
  });

  CartItem toCartItem() {
    return CartItem(
      id: id,
      cartId: cartId,
      product: product,
      quantity: quantity,
      unitPrice: unitPrice,
      discountedPrice: discountedPrice,
    );
  }
}
