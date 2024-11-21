import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_app/data/local/dao/user_dao.dart';
import 'package:flutter_app/data/local/entities/user_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/product_dao.dart';
import '../entities/product_entity.dart';

part 'database_factory.g.dart';

@Database(version: 1, entities: [ProductEntity, UserEntity])
abstract class AppDatabase extends FloorDatabase {
  ProductDao get productDao;
  UserDao get userDao;
}

class DatabaseFactory {
  static final DatabaseFactory _instance = DatabaseFactory._();
  static Completer<AppDatabase>? _completer;

  DatabaseFactory._();

  factory DatabaseFactory() {
    return _instance;
  }

  Future<AppDatabase> getDatabase() async {
    if (_completer == null) {
      _completer = Completer<AppDatabase>();
      $FloorAppDatabase.databaseBuilder('rustic.db').build().then((value) {
        _completer!.complete(value);
      });
      return _completer!.future;
    }
    return _completer!.future;
  }
}
