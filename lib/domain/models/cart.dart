class Cart {
  final String id;
  final String userId;
  final Map<String, dynamic> items;
  final String total;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
  });
}
