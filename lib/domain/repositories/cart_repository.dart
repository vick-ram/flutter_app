import 'package:dio/dio.dart';
import 'package:flutter_app/data/remote/api/constants.dart';
import 'package:flutter_app/data/remote/dto/cart_dto.dart';
import 'package:flutter_app/domain/models/product.dart';

abstract class CartRepository {
  Future<ApiResponse<CartDto>> addProductToCart(
      Dio dio, Product product, int quantity);
  Future<ApiResponse<void>> removeProductFromCart(Dio dio, Product product);
  Future<ApiResponse<CartDto>> updateProductQuantity(
      Dio dio, Product product, int quantity);
  Future<ApiResponse<List<CartDto>>> getCartProducts(Dio dio);
}
