// const String baseUrl = 'http://192.168.1.55:8080';
const String baseUrl = 'http://192.168.88.254:8080';

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
