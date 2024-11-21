import 'package:dio/dio.dart';
import 'package:flutter_app/data/remote/api/constants.dart';
import 'package:flutter_app/data/remote/dto/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRepository {
  Future<ApiResponse<TokenResponse>> login(
      Dio dio, SharedPreferences prefs, String email, String password);
  Future<ApiResponse<UserDto>> signUp(Dio dio, String firstName,
      String lastName, String email, String password, String phone);
  Future<ApiResponse<UserDto>> getByEmail(Dio dio, String email);
  Future<ApiResponse<UserDto>> getUserById(Dio dio, String id);
}
