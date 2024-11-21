import 'package:flutter_app/data/remote/api/constants.dart';
import 'package:flutter_app/data/remote/dto/cart_dto.dart';
import 'package:flutter_app/domain/models/product.dart';
import 'package:flutter_app/domain/repositories/cart_repository.dart';
import 'package:dio/dio.dart';

class CartService implements CartRepository {
  @override
  Future<ApiResponse<CartDto>> addProductToCart(
      Dio dio, Product product, int quantity) async {
    return await _addProductToCart(dio, product, quantity);
  }

  @override
  Future<ApiResponse<void>> removeProductFromCart(
      Dio dio, Product product) async {
    return await _removeProductFromCart(dio, product);
  }

  @override
  Future<ApiResponse<CartDto>> updateProductQuantity(
      Dio dio, Product product, int quantity) async {
    return await _updateCartQuantity(dio, product, quantity);
  }

  @override
  Future<ApiResponse<List<CartDto>>> getCartProducts(Dio dio) async {
    return await _getCartProducts(dio);
  }
}

Future<ApiResponse<CartDto>> _addProductToCart(
    Dio dio, Product product, int quantity) async {
  try {
    final response = await dio.post('/cart', data: null, queryParameters: {
      'productId': product.id,
      'quantity': quantity,
    });
    final bool status = response.data['status'] ?? false;
    final String message = response.data['message'] ?? '';
    final Map<String, dynamic> cartJson = response.data['data'] ?? {};

    if (status == true) {
      final cartDto = CartDto.fromJson(cartJson);
      return ApiResponse(success: true, message: message, data: cartDto);
    } else {
      return ApiResponse(success: false, message: message);
    }
  } catch (e) {
    return ApiResponse(success: false, message: 'An error occurred: $e');
  }
}

Future<ApiResponse<CartDto>> _updateCartQuantity(
    Dio dio, Product product, int quantity) async {
  try {
    final response = await dio.patch(
      '/cart/${product.id}',
      data: null,
      queryParameters: {'quantity': quantity},
    );
    final bool status = response.data['status'] ?? false;
    final String message = response.data['message'] ?? '';
    final Map<String, dynamic> cartJson = response.data['data'] ?? {};

    if (status == true) {
      final cartDto = CartDto.fromJson(cartJson);
      return ApiResponse(success: true, message: message, data: cartDto);
    } else {
      return ApiResponse(success: false, message: message);
    }
  } catch (e) {
    return ApiResponse(success: false, message: 'An error occurred: $e');
  }
}

Future<ApiResponse<void>> _removeProductFromCart(
    Dio dio, Product product) async {
  try {
    final response =
        await dio.delete('/cart', queryParameters: {'productId': product.id});
    final bool status = response.data['status'] ?? false;
    final String message = response.data['message'] ?? '';

    if (status == true) {
      return ApiResponse(success: true, message: message);
    } else {
      return ApiResponse(success: false, message: message);
    }
  } catch (e) {
    return ApiResponse(success: false, message: 'An error occurred: $e');
  }
}

Future<ApiResponse<List<CartDto>>> _getCartProducts(Dio dio) async {
  try {
    final response = await dio.get('/cart');
    final bool status = response.data['status'] ?? false;
    final String message = response.data['message'] ?? '';
    final List cartJson = response.data['data'] ?? [];

    if (status == true) {
      List<CartDto> cartDtos =
          cartJson.map((cart) => CartDto.fromJson(cart)).toList();
      return ApiResponse(success: true, message: message, data: cartDtos);
    } else {
      return ApiResponse(success: false, message: message);
    }
  } catch (e) {
    return ApiResponse(success: false, message: 'An error occurred: $e');
  }
}
