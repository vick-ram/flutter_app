import 'package:jwt_decoder/jwt_decoder.dart';

Map<String, dynamic> jwtDecode(token) {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  return decodedToken;
}
