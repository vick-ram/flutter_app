import 'package:floor/floor.dart';
import 'package:flutter_app/domain/models/user.dart';

@Entity(tableName: 'users')
class UserEntity {
  @PrimaryKey(autoGenerate: false)
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String createdAt;
  final String updatedAt;

  UserEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.createdAt,
      required this.updatedAt});

  User toUser() {
    return User(
      id: id,
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
  }
}
