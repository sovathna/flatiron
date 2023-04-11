import 'package:flatiron/const.dart';
import 'package:flatiron/data/app_service.dart';
import 'package:flatiron/main.dart';
import 'package:http/http.dart' as http;

class AppServiceImpl implements AppService {
  final http.Client _client;

  AppServiceImpl(this._client);

  @override
  Future<http.Response> signin(String phone) async {
    final url = Const.signin;
    final headers = Const.signinHeaders;
    final requestBody = {
      "phone": phone.substring(1),
      "phoneAreaCode": "855",
    };
    logger.d("Request: $url\n$headers\n$requestBody");
    final uri = Uri.parse(url);
    final res = await _client.post(
      uri,
      body: requestBody,
      headers: headers,
    );
    final log =
        "Response: ${res.statusCode} ${res.reasonPhrase}\n${res.headers}\n${res.body}";
    logger.d(log);
    return res;
  }

  @override
  Future<http.Response> verifyOTP(String phone, String otp) async {
    final url = Const.verifyOtp;
    final headers = Const.signinHeaders;
    final requestBody = {
      "phone": phone.substring(1),
      "phoneAreaCode": "855",
      "otp": otp,
      "clientId": Const.clientId,
    };
    logger.d("Request: $url\n$headers\n$requestBody");
    final uri = Uri.parse(url);
    final res = await _client.post(
      uri,
      body: requestBody,
      headers: headers,
    );
    final log =
        "Response: ${res.statusCode} ${res.reasonPhrase}\n${res.headers}\n${res.body}";
    logger.d(log);
    return res;
  }

  @override
  Future<http.Response> getFloor(
      String cardNumber, String bearerToken, String floor) async {
    final url = "${Const.getFloor}?cardNo=$cardNumber&mainFloor=$floor";
    final headers = Const.signinHeaders
      ..putIfAbsent("authorization", () => "Bearer $bearerToken");
    logger.d("Request: $url\n$headers");
    final uri = Uri.parse(url);
    final res = await _client.get(
      uri,
      headers: headers,
    );
    final log =
        "Response: ${res.statusCode} ${res.reasonPhrase}\n${res.headers}\n${res.body}";
    logger.d(log);
    return res;
  }

  @override
  Future<http.Response> refreshFloorSession(
      String bearerToken, String value) async {
    final url = "${Const.getLift}$value";
    final headers = Const.signinHeaders
      ..putIfAbsent("authorization", () => "Bearer $bearerToken");
    logger.d("Request: $url\n$headers");
    final uri = Uri.parse(url);
    final res = await _client.get(
      uri,
      headers: headers,
    );
    final log =
        "Response: ${res.statusCode} ${res.reasonPhrase}\n${res.headers}\n${res.body}";
    logger.d(log);
    return res;
  }
}
