import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'http://192.168.88.246:8080';

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });
}

final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }));

Future<SharedPreferences> initializePreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}
