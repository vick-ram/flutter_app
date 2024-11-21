class Product {
  final String id;
  final String name;
  final String shortDescription;
  final String detailedDescription;
  final String price;
  final int quantity;
  final String category;
  final String? image;
  final String? discount;
  final bool favourite;

  Product({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.detailedDescription,
    required this.price,
    required this.quantity,
    required this.category,
    this.image,
    this.discount,
    required this.favourite,
  });
}
