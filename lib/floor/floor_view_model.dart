import 'dart:convert';

import 'package:flatiron/data/app_service.dart';
import 'package:flatiron/floor/floor_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloorViewModel extends StateNotifier<FloorState> {
  final AppService _service;
  FloorViewModel(this._service) : super(FloorState());

  void getFloor(int floor) async {
    state = state.copyWith(
      isInit: false,
      isLoading: true,
      error: null,
    );
    try {
      final res = await _service.getFloor(floor);
      print(res);
      state = state.copyWith(
        isLoading: false,
        imageData: base64Decode(res.imageData.split("base64,")[1]),
        value: res.value,
      );
    } on Exception catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
        error: "An error has occurred",
      );
    }
  }
}
