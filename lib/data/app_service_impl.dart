import 'dart:convert';
import 'dart:io';

import 'package:flatiron/const.dart';
import 'package:flatiron/data/app_service.dart';
import 'package:flatiron/main.dart';
import 'package:flatiron/model/floor.dart';
import 'package:http/http.dart' as http;

class AppServiceImpl implements AppService {
  final http.Client _client;

  AppServiceImpl(this._client);

  @override
  Future<http.Response> signin(String phone) async {
    final url = Const.signin;
    logger.d("Request: $url");
    final uri = Uri.parse(url);
    final res = await _client.post(
      uri,
      body: jsonEncode({
        "phone": phone.substring(1),
        "phoneAreaCode": "855",
        "email": null,
      }),
      headers: Const.floorHeaders,
    );
    final tmp = "Response: ${res.statusCode} ${res.reasonPhrase}\n${res.body}";
    logger.d(tmp);
    return res;
  }

  @override
  Future<http.Response> verifyOTP(String phone, String otp) async {
    final url = Const.verifyOtp;
    logger.d("Request: $url");
    final uri = Uri.parse(url);
    final res = await _client.post(
      uri,
      body: jsonEncode({
        "phone": phone.substring(1),
        "phoneAreaCode": "855",
        "email": null,
        "otp": otp,
        "clientId":
            "A857D7C7F5DC0B2BC69F2AC40F58C0D2985405646BA32B3F1C66C7CA7ADD335A"
      }),
      headers: Const.floorHeaders,
    );
    final tmp = "Response: ${res.statusCode} ${res.reasonPhrase}\n${res.body}";
    logger.d(tmp);
    return res;
  }

  @override
  Future<FloorResponse> getFloor(String floor) async {
    final url = "${Const.getFloor}?cardNo=${Const.cardNumber}&mainFloor=$floor";
    logger.d("Request: $url");
    final uri = Uri.parse(url);
    final res = await _client.get(
      uri,
      headers: Const.floorHeaders,
    );
    final tmp = "Response: ${res.statusCode} ${res.reasonPhrase}\n${res.body}";
    logger.d(tmp);
    return FloorResponse.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  @override
  Future<String> getLift(String value) async {
    final url = "${Const.getLift}$value";
    logger.d("Request: $url");
    final uri = Uri.parse(url);
    final res = await _client.get(
      uri,
      headers: Const.floorHeaders,
    );
    final tmp = "Response: ${res.statusCode} ${res.reasonPhrase}\n${res.body}";
    logger.d(tmp);
    return res.body;
  }
}
