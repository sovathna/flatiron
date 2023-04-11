import 'package:http/http.dart';

abstract class AppService {
  Future<Response> signin(String phone);
  Future<Response> verifyOTP(String phone, String otp);
  Future<Response> getFloor(
      String cardNumber, String bearerToken, String floor);
  Future<Response> refreshFloorSession(String bearerToken, String value);
}
