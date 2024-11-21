import 'package:dio/dio.dart';
import 'package:flutter_app/data/local/db/database_factory.dart';
import 'package:flutter_app/data/remote/api/services/product_service.dart';
import 'package:flutter_app/data/remote/api/services/user_service.dart';
import 'package:flutter_app/di/service_locator.dart';
import 'package:flutter_app/util/decode_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sync {
  final AppDatabase database;
  final ProductService productService;
  final UserService userService;
  final Dio dio;
  final SharedPreferences prefs;

  Sync._(
      {required this.database,
      required this.productService,
      required this.userService,
      required this.dio,
      required this.prefs});

  static Future<Sync> create() async {
    final database = await getIt.getAsync<AppDatabase>();
    final productService = getIt<ProductService>();
    final userService = getIt<UserService>();
    final dio = await getIt.getAsync<Dio>();
    final prefs = await getIt.getAsync<SharedPreferences>();
    return Sync._(
        database: database,
        productService: productService,
        userService: userService,
        dio: dio,
        prefs: prefs);
  }

  Future<void> syncProducts() async {
    try {
      final apiProducts = await productService.fetchProducts(dio);
      if (apiProducts.success == true) {
        final productsEntity = apiProducts.data?.map((product) {
          return product.toEntity();
        }).toList();
        if (productsEntity != null) {
          await database.productDao.deleteAllProducts();
          await database.productDao.insertProducts(productsEntity);
        }
      } else {
        print('Failed to fetch products: ${apiProducts.message}');
      }
    } catch (e) {
      print('Error during sync: $e');
    }
  }

  Future<void> syncUser() async {
    try {
      final token = prefs.getString('token');
      final decodedToken = jwtDecode(token);
      final userId = decodedToken['sub'];
      print('User ID: $userId');
      final user = await database.userDao.getUserById(userId);
      if (user != null) {
        final apiUser = await userService.getUserById(dio, userId);
        if (apiUser.success == true) {
          final userEntity = apiUser.data?.toEntity();
          if (userEntity != null) {
            await database.userDao.deleteUser(user);
            await database.userDao.insertUser(userEntity);
          }
        } else {
          print('Failed to fetch user: ${apiUser.message}');
        }
      }
    } catch (e) {
      print('Error during sync: $e');
    }
  }
}
