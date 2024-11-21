import 'package:flutter_app/data/remote/dto/product_dto.dart';
import 'package:flutter_app/domain/repositories/product_repository.dart';

import '../constants.dart';
import 'package:dio/dio.dart';

class ProductService implements ProductRepository {
  @override
  Future<ApiResponse<ProductDto>> fetchProduct(Dio dio, String id) async {
    return _fetchProduct(dio, id);
  }

  @override
  Future<ApiResponse<List<ProductDto>>> fetchProducts(Dio dio) async {
    return _fetchProducts(dio);
  }
}

Future<ApiResponse<List<ProductDto>>> _fetchProducts(Dio dio) async {
  try {
    final response = await dio.get('/products');

    final bool status = response.data['status'] ?? false;
    final String message = response.data['message'];
    final List productJson = response.data['data'] ?? [];

    if (status == true) {
      if (productJson.isEmpty) {
        return ApiResponse(success: false, message: 'No products available');
      }

      List<ProductDto> products = productJson.map((product) {
        return ProductDto.fromJson(product);
      }).toList();

      return ApiResponse(success: true, message: message, data: products);
    } else {
      return ApiResponse(success: false, message: message);
    }
  } catch (e) {
    return ApiResponse(success: false, message: 'Failed to fetch products');
  }
}

Future<ApiResponse<ProductDto>> _fetchProduct(Dio dio, String id) async {
  try {
    final response = await dio.get('/products/$id');

    final bool status = response.data['status'] ?? false;
    final String message = response.data['message'];
    final Map<String, dynamic> productJson = response.data['data'] ?? {};

    if (status == true) {
      ProductDto product = ProductDto.fromJson(productJson);

      return ApiResponse(success: true, message: message, data: product);
    } else {
      return ApiResponse(success: false, message: message);
    }
  } catch (e) {
    return ApiResponse(success: false, message: 'Failed to fetch products');
  }
}
