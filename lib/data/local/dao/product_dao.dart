import 'package:floor/floor.dart';
import 'package:flutter_app/data/local/entities/product_entity.dart';

@dao
abstract class ProductDao {
  @Query('SELECT * FROM Product')
  Future<List<ProductEntity>> fetchAllProducts();

  @Query('SELECT * FROM Product WHERE id = :id')
  Stream<ProductEntity?> fetchProduct(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProduct(ProductEntity product);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProducts(List<ProductEntity> products);

  @Query('DELETE FROM Product')
  Future<void> deleteAllProducts();
}
