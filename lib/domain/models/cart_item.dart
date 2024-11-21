class CartItem {
  final String id;
  final String cartId;
  final Map<String, dynamic> product;
  final int quantity;
  final String unitPrice;
  final String discountedPrice;

  CartItem({
    required this.id,
    required this.cartId,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.discountedPrice,
  });
}
