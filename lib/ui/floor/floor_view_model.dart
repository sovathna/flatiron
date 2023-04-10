import 'dart:async';

import 'package:flatiron/data/app_service.dart';
import 'package:flatiron/ui/floor/floor_state.dart';
import 'package:flatiron/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class FloorViewModel extends StateNotifier<FloorState> {
  FloorViewModel(this._floor, this._service, this._box)
      : super(const FloorState());

  final String _floor;
  final Box _box;

  final AppService _service;
  Timer? _timer;

  void getFloor() async {
    if (state.isLoading) return;
    try {
      _cancelTimer();
      state = const FloorState(isInit: false, isLoading: true);
      final tmp = _box.get("otp_verification_response") as Map;

      final res = await _service.getFloor(
        tmp['data']['hikvisionCardNo'],
        tmp['token'],
        _floor,
      );
      logger.d("Response: ${res.toJson()}");
      state = state.copyWith(
        isLoading: false,
        value: res.value,
        elapse: 0,
      );
      elapsing();
    } on Exception catch (e) {
      logger.e(e);
      state = state.copyWith(
        isLoading: false,
        error: "An error has occurred",
      );
    }
  }

  void refresh() async {
    if (state.isLoading) return;
    try {
      _cancelTimer();
      state = state.copyWith(isLoading: true, error: "");
      final tmp = _box.get("otp_verification_response") as Map;
      final res = await _service.getLift(tmp['token'], state.value);
      logger.d("Response: $res");
      state = state.copyWith(isLoading: false, elapse: 0);
      elapsing();
    } on Exception catch (e) {
      logger.e(e);
      state = state.copyWith(
        isLoading: false,
        error: "An error has occurred",
      );
    }
  }

  void elapsing() {
    _cancelTimer();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        state = state.copyWith(elapse: state.elapse + 1);
      },
    );
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _cancelTimer() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }
}
