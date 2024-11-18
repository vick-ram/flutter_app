class Product {
  final String id;
  final String name;
  final String shortDescription;
  final String detailedDescription;
  final String price;
  final int quantity;
  final String sku;
  final String category;
  final String? image;
  final String? discount;
  final bool favourite;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.detailedDescription,
    required this.price,
    required this.quantity,
    required this.sku,
    required this.category,
    this.image,
    this.discount,
    required this.favourite,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Product',
      shortDescription: json['shortDescription'] ?? '',
      detailedDescription: json['detailedDescription'] ?? '',
      price: json['price'] ?? '0.00',
      quantity: json['quantity'] ?? 0,
      sku: json['sku'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
      discount: json['discount'] ?? '0.00',
      favourite: json['favourite'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
