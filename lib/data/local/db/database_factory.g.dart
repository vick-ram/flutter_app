// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_factory.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Product` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `shortDescription` TEXT NOT NULL, `detailedDescription` TEXT NOT NULL, `price` TEXT NOT NULL, `quantity` INTEGER NOT NULL, `sku` TEXT NOT NULL, `category` TEXT NOT NULL, `image` TEXT, `discount` TEXT, `favourite` INTEGER NOT NULL, `createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `phone` TEXT NOT NULL, `createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _productEntityInsertionAdapter = InsertionAdapter(
            database,
            'Product',
            (ProductEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'shortDescription': item.shortDescription,
                  'detailedDescription': item.detailedDescription,
                  'price': item.price,
                  'quantity': item.quantity,
                  'sku': item.sku,
                  'category': item.category,
                  'image': item.image,
                  'discount': item.discount,
                  'favourite': item.favourite ? 1 : 0,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductEntity> _productEntityInsertionAdapter;

  @override
  Future<List<ProductEntity>> fetchAllProducts() async {
    return _queryAdapter.queryList('SELECT * FROM Product',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as String,
            name: row['name'] as String,
            shortDescription: row['shortDescription'] as String,
            detailedDescription: row['detailedDescription'] as String,
            price: row['price'] as String,
            quantity: row['quantity'] as int,
            sku: row['sku'] as String,
            category: row['category'] as String,
            image: row['image'] as String?,
            discount: row['discount'] as String?,
            favourite: (row['favourite'] as int) != 0,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String));
  }

  @override
  Stream<ProductEntity?> fetchProduct(String id) {
    return _queryAdapter.queryStream('SELECT * FROM Product WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProductEntity(
            id: row['id'] as String,
            name: row['name'] as String,
            shortDescription: row['shortDescription'] as String,
            detailedDescription: row['detailedDescription'] as String,
            price: row['price'] as String,
            quantity: row['quantity'] as int,
            sku: row['sku'] as String,
            category: row['category'] as String,
            image: row['image'] as String?,
            discount: row['discount'] as String?,
            favourite: (row['favourite'] as int) != 0,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String),
        arguments: [id],
        queryableName: 'Product',
        isView: false);
  }

  @override
  Future<void> deleteAllProducts() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Product');
  }

  @override
  Future<void> insertProduct(ProductEntity product) async {
    await _productEntityInsertionAdapter.insert(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertProducts(List<ProductEntity> products) async {
    await _productEntityInsertionAdapter.insertList(
        products, OnConflictStrategy.replace);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'password': item.password,
                  'phone': item.phone,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _userEntityUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'password': item.password,
                  'phone': item.phone,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _userEntityDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['id'],
            (UserEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'password': item.password,
                  'phone': item.phone,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  final UpdateAdapter<UserEntity> _userEntityUpdateAdapter;

  final DeletionAdapter<UserEntity> _userEntityDeletionAdapter;

  @override
  Future<UserEntity?> getUserById(String id) async {
    return _queryAdapter.query('SELECT * FROM User WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserEntity(
            id: row['id'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            phone: row['phone'] as String,
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertUser(UserEntity user) async {
    await _userEntityInsertionAdapter.insert(user, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    await _userEntityUpdateAdapter.update(user, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteUser(UserEntity user) async {
    await _userEntityDeletionAdapter.delete(user);
  }
}
