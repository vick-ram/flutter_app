import 'package:flutter_app/data/local/db/database_factory.dart';
import 'package:flutter_app/data/remote/api/services/cart_service.dart';
import 'package:flutter_app/data/remote/api/services/product_service.dart';
import 'package:flutter_app/data/remote/api/services/user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/local/db/sync.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  getIt.registerSingletonAsync<Dio>(() async {
    return Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.55:8080',
        connectTimeout: const Duration(seconds: 5000),
        receiveTimeout: const Duration(seconds: 3000),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  });
  getIt.registerSingleton<ProductService>(ProductService());
  getIt.registerSingleton<UserService>(UserService());
  getIt.registerSingleton<CartService>(CartService());
  getIt.registerLazySingletonAsync<AppDatabase>(() async {
    final database = await DatabaseFactory().getDatabase();
    return database;
  });
  getIt.registerLazySingletonAsync<SharedPreferences>(
    () async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    },
  );
  getIt.registerLazySingletonAsync<Sync>(() async {
    return await Sync.create();
  });
}
