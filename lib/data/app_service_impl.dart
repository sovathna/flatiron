import 'dart:convert';

import 'package:flatiron/const.dart';
import 'package:flatiron/data/app_service.dart';
import 'package:flatiron/model/floor.dart';
import 'package:http/http.dart' as http;

class AppServiceImpl implements AppService {
  final http.Client _client;

  AppServiceImpl(this._client);

  @override
  Future<FloorResponse> getFloor(int floor) async {
    final url = "${Const.getFloor}?cardNo=${Const.cardNumber}&mainFloor=$floor";
    print(url);
    final res = await _client.get(
      Uri.parse(url),
      headers: Const.floorHeaders,
    );
    return FloorResponse.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }
}