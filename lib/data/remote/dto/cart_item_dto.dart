import 'package:flutter_app/data/local/entities/cart_item_entity.dart';

class CartItemDto {
  final String id;
  final String cartId;
  final Map<String, dynamic> product;
  final int quantity;
  final String unitPrice;
  final String discountedPrice;

  CartItemDto({
    required this.id,
    required this.cartId,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.discountedPrice,
  });

  CartItemDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cartId = json['cartId'],
        product = json['product'],
        quantity = json['quantity'],
        unitPrice = json['unitPrice'],
        discountedPrice = json['discountedPrice'];

  CartItemEntity toEntity() {
    return CartItemEntity(
      id: id,
      cartId: cartId,
      product: product,
      quantity: quantity,
      unitPrice: unitPrice,
      discountedPrice: discountedPrice,
    );
  }
}
