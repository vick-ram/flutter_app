import 'package:floor/floor.dart';
import 'package:flutter_app/data/local/entities/cart_entity.dart';
import 'package:flutter_app/domain/models/cart_item.dart';

@dao
abstract class CartDao {
  @Query('SELECT * FROM carts')
  Future<List<CartEntity>> findAllProductsInCart();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllProductsToCarts(List<CartEntity> carts);

  // @update
  // Future<void> updateProductCartQuantity(Cart cart);

  // @update
  // Future<void> updateCarts(List<Cart> carts);

  @delete
  Future<void> deleteProductFromCart(CartItem cartItem);

  @Query('DELETE FROM carts')
  Future<void> deleteAllProductsFromCart();
}
