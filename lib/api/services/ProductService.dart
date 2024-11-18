import '../dto/Product.dart';
import '../constants.dart';
import 'package:dio/dio.dart';

Future<ApiResponse<List<Product>>> fetchProducts(Dio dio) async {
  try {
    final response = await dio.get('/products');

    final bool status = response.data['status'] ?? false;
    final String message = response.data['message'];
    final List productJson = response.data['data'] ?? [];

    if (status == true) {
      if (productJson.isEmpty) {
        return ApiResponse(success: false, message: 'No products available');
      }

      List<Product> products = productJson.map((product) {
        return Product.fromJson(product);
      }).toList();

      return ApiResponse(success: true, message: message, data: products);
    } else {
      return ApiResponse(success: false, message: message);
    }
  } catch (e) {
    return ApiResponse(success: false, message: 'Failed to fetch products');
  }
}

Future<ApiResponse<Product>> fetchProduct(Dio dio, String id) async {
  try {
    final response = await dio.get('/products/$id');

    final bool status = response.data['status'] ?? false;
    final String message = response.data['message'];
    final Map<String, dynamic> productJson = response.data['data'] ?? {};

    if (status == true) {
      Product product = Product.fromJson(productJson);

      return ApiResponse(success: true, message: message, data: product);
    } else {
      return ApiResponse(success: false, message: message);
    }
  } catch (e) {
    return ApiResponse(success: false, message: 'Failed to fetch products');
  }
}
