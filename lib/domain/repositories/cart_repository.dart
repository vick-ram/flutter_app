import 'package:flutter_app/data/remote/api/constants.dart';
import 'package:flutter_app/domain/models/product.dart';

abstract class CartRepository {
  Future<void> addProductToCart(Product product);
  Future<void> removeProductFromCart(Product product);
  // Future<List<ApiResponse<PrductD> getCartProducts();
}
