import 'package:dio/dio.dart';
import 'package:flutter_app/data/remote/api/constants.dart';
import 'package:flutter_app/data/remote/dto/product_dto.dart';

abstract class ProductRepository {
  Future<ApiResponse<List<ProductDto>>> fetchProducts(Dio dio);
  Future<ApiResponse<ProductDto>> fetchProduct(Dio dio, String id);
  // Future<Product> createProduct(Product product);
  // Future<Product> updateProduct(Product product);
  // Future<void> deleteProduct(int id);
}
