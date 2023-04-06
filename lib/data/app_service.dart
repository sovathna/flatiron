import 'package:flatiron/model/floor.dart';

abstract class AppService {
  Future<FloorResponse> getFloor(int floor);
}
