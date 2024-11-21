import 'package:flutter_app/data/local/db/database_factory.dart';
import 'package:flutter_app/data/remote/dto/user_dto.dart';
import 'package:flutter_app/di/service_locator.dart';
import 'package:flutter_app/domain/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../constants.dart';

class UserService implements UserRepository {
  @override
  Future<ApiResponse<TokenResponse>> login(
      Dio dio, SharedPreferences prefs, String email, String password) async {
    return await _login(dio, email, password, prefs);
  }

  @override
  Future<ApiResponse<UserDto>> signUp(Dio dio, String firstName,
      String lastName, String email, String password, String phone) async {
    return await _signUp(dio, firstName, lastName, email, password, phone);
  }

  @override
  Future<ApiResponse<UserDto>> getByEmail(Dio dio, String email) async {
    return await _getByEmail(dio, email);
  }

  @override
  Future<ApiResponse<UserDto>> getUserById(Dio dio, String id) async {
    return await _getUserById(dio, id);
  }
}

Future<ApiResponse<TokenResponse>> _login(
    Dio dio, String email, String password, SharedPreferences prefs) async {
  AppDatabase database = await getIt.getAsync<AppDatabase>();
  final response = await dio
      .post('/users/auth/login', data: {'email': email, 'password': password});
  final bool status = response.data['status'] ?? false;
  final String message = response.data['message'] ?? '';
  final Map<String, dynamic> tokenJson = response.data['data'] ?? {};

  try {
    if (status == true) {
      final userResponse = await _getByEmail(dio, email);
      final userDto = userResponse.data!;
      final userEntity = userDto.toEntity();

      await database.userDao.deleteUser(userEntity);
      await database.userDao.insertUser(userEntity);
      final token = TokenResponse.fromJson(tokenJson);
      prefs.setString('token', token.token);
      return ApiResponse(success: true, message: message, data: token);
    } else {
      return ApiResponse(success: false, message: message);
    }
  } catch (e) {
    return ApiResponse(success: false, message: 'An error occurred: $e');
  }
}

Future<ApiResponse<UserDto>> _signUp(Dio dio, String firstName, String lastName,
    String email, String password, String phone) async {
  AppDatabase database = await getIt.getAsync<AppDatabase>();
  final response = await dio.post('/users/auth/register', data: {
    'name': '$firstName $lastName',
    'email': email,
    'password': password,
    'phone': phone,
  });
  final bool status = response.data['status'] ?? false;
  final String message = response.data['message'] ?? '';
  final Map<String, dynamic> userJson = response.data['data'] ?? {};

  if (status == true) {
    final user = UserDto.fromJson(userJson);
    final userEntity = user.toEntity();
    await database.userDao.deleteUser(userEntity);
    await database.userDao.insertUser(userEntity);
    return ApiResponse(success: true, message: message, data: user);
  } else {
    return ApiResponse(success: false, message: message);
  }
}

Future<ApiResponse<UserDto>> _getByEmail(Dio dio, String email) async {
  final response = await dio.get('/users', queryParameters: {'email': email});
  final bool status = response.data['status'] ?? false;
  final String message = response.data['message'] ?? '';
  final Map<String, dynamic> userJson = response.data['data'] ?? {};

  if (status == true) {
    final user = UserDto.fromJson(userJson);
    return ApiResponse(success: true, message: message, data: user);
  } else {
    return ApiResponse(success: false, message: message);
  }
}

Future<ApiResponse<UserDto>> _getUserById(Dio dio, String id) async {
  final response = await dio.get('/users/$id');
  final bool status = response.data['status'] ?? false;
  final String message = response.data['message'] ?? '';
  final Map<String, dynamic> userJson = response.data['data'] ?? {};

  if (status == true) {
    final user = UserDto.fromJson(userJson);
    return ApiResponse(success: true, message: message, data: user);
  } else {
    return ApiResponse(success: false, message: message);
  }
}
