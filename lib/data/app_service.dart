import 'package:flatiron/model/floor.dart';
import 'package:http/http.dart';

abstract class AppService {
  Future<Response> signin(String phone);
  Future<Response> verifyOTP(String phone, String otp);
  Future<FloorResponse> getFloor(
      String cardNumber, String bearerToken, String floor);
  Future<String> getLift(String bearerToken, String value);
}
