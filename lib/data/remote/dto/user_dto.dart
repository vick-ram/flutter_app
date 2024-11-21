import 'package:flutter_app/data/local/entities/user_entity.dart';

class TokenResponse {
  final String token;

  TokenResponse({required this.token});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(token: json['token']);
  }
}

class UserDto {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String createdAt;
  final String updatedAt;

  UserDto(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.createdAt,
      required this.updatedAt});

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        phone: json['phone'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }

  UserEntity toEntity() {
    return UserEntity(
        id: id,
        name: name,
        email: email,
        password: password,
        phone: phone,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }
}
