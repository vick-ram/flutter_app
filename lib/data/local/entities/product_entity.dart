import 'package:floor/floor.dart';
import 'package:flutter_app/domain/models/Product.dart';

@Entity(tableName: 'Product')
class ProductEntity {
  @primaryKey
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
  final String createdAt;
  final String updatedAt;

  ProductEntity({
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

  Product toProduct() {
    return Product(
      id: id,
      name: name,
      shortDescription: shortDescription,
      detailedDescription: detailedDescription,
      price: price,
      quantity: quantity,
      category: category,
      image: image,
      discount: discount,
      favourite: favourite,
    );
  }
}
