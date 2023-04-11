import 'dart:convert';

import 'package:flatiron/const.dart';
import 'package:hive_flutter/adapters.dart';

class AppPreferences {
  static const String _responseKey = "otp_verification_response";

  const AppPreferences(this._box);
  final Box _box;

  Map get _res => _box.get("otp_verification_response") as Map;
  Map get _data => _res['data'] as Map;

  bool hasData() => _box.containsKey(_responseKey);

  Future<void> putData(String body) async {
    final maps = jsonDecode(body) as Map;
    return await _box.put("otp_verification_response", maps);
  }

  String getCardNumber() {
    return _data['hikvisionCardNo'];
  }

  String getToken() {
    return _res['token'] as String;
  }

  String getFirstName() => _data['firstName'];

  String getLastName() => _data['lastName'];

  String getName() => "${getFirstName()} ${getLastName()}";

  String getPhone() => "0${_data['phone']}";

  String getMainFloor() {
    if (getCardNumber() == Const.myCardNumber) return "18";
    return _data['hikvisionMainFloor'] as String;
  }

  List<String> getFloors() {
    final tmp = _data['hikvisionSecondaryFloors'];
    return tmp.split(",");
  }

  void clear() {
    _box.clear();
  }
}
