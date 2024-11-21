import 'package:floor/floor.dart';
import 'package:flutter_app/data/local/entities/user_entity.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM users WHERE id = :id')
  Future<UserEntity?> getUserById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUser(UserEntity user);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUser(UserEntity user);

  @delete
  Future<void> deleteUser(UserEntity user);
}
