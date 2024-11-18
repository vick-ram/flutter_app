import 'package:flutter_app/api/dto/userModels.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

Future<ApiResponse<TokenResponse>> login(
    String email, String password, SharedPreferences prefs) async {
  final response = await dio
      .post('/users/auth/login', data: {'email': email, 'password': password});
  final bool status = response.data['status'] ?? false;
  final String message = response.data['message'] ?? '';
  final Map<String, dynamic> tokenJson = response.data['data'] ?? {};

  if (status == true) {
    final token = TokenResponse.fromJson(tokenJson);
    prefs.setString('token', token.token);
    return ApiResponse(success: true, message: message, data: token);
  } else {
    return ApiResponse(success: false, message: message);
  }
}
