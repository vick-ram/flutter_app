import 'package:flutter_app/data/local/entities/cart_entity.dart';

class CartDto {
  final String id;
  final String userId;
  final Map<String, dynamic> items;
  final String total;

  CartDto({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) {
    return CartDto(
      id: json['id'],
      userId: json['userId'],
      items: json['items'],
      total: json['total'],
    );
  }

  CartEntity toEntity() {
    return CartEntity(
      id: id,
      userId: userId,
      items: items,
      total: total,
    );
  }
}
