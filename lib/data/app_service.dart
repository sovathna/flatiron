import 'package:flatiron/model/floor.dart';

abstract class AppService {
  Future<FloorResponse> getFloor(String floor);
  Future<String> getLift(String value);
}
