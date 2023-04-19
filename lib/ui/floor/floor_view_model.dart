import 'dart:async';
import 'dart:convert';

import 'package:flatiron/data/app_preferences.dart';
import 'package:flatiron/data/app_service.dart';
import 'package:flatiron/model/floor.dart';
import 'package:flatiron/ui/floor/floor_state.dart';
import 'package:flatiron/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloorViewModel extends StateNotifier<FloorState> {
  FloorViewModel(this._floor, this._service, this._pref)
      : super(const FloorState());

  final String _floor;
  final AppPreferences _pref;
  final AppService _service;
  Timer? _timer;
  int _elapsed = 0;

  void getFloor() async {
    if (state.isLoading) return;
    try {
      _cancelTimer();
      state = const FloorState(isInit: false, isLoading: true);
      final res = await _service.getFloor(
        _pref.getCardNumber(),
        _pref.getToken(),
        _floor,
      );
      if (!mounted) return;
      if (res.statusCode == 200) {
        final data = FloorResponse.fromJson(
            jsonDecode(res.body) as Map<String, dynamic>);
        state = state.copyWith(isLoading: false, data: data);
        _elapsing();
      } else {
        state = state.copyWith(
          isLoading: false,
          error: "An error has occurred! [${res.statusCode}]",
        );
      }
    } on Exception catch (e) {
      logger.e(e);
      state = state.copyWith(
        isLoading: false,
        error: "An error has occurred!",
      );
    }
  }

  void _refreshSession() async {
    if (state.isLoading) return;
    try {
      _cancelTimer();
      state = state.copyWith(isLoading: true, error: "");
      final res = await _service.refreshFloorSession(
          _pref.getToken(), state.data!.value);
      if (!mounted) return;
      if (res.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        _elapsing();
      } else {
        state = state.copyWith(
          isLoading: false,
          error: "An error has occurred! [${res.statusCode}]",
        );
      }
    } on Exception catch (e) {
      logger.e(e);
      state = state.copyWith(
        isLoading: false,
        error: "An error has occurred!",
      );
    }
  }

  void _elapsing() {
    _elapsed = 0;
    _cancelTimer();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) _cancelTimer();
        _elapsed = _elapsed + 1;
        // logger.d("elapsed: $_elapsed");
        if (_elapsed > 30) _refreshSession();
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
