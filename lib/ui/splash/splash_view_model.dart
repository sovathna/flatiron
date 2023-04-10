import 'package:flatiron/ui/splash/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel(this._box) : super(const SplashState()) {
    _init();
  }

  final Box _box;

  void _init() async {
    state = state.copyWith(isInit: false, isLoading: true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    final isSuccess = _box.containsKey("otp_verification_response");
    state = state.copyWith(isLoading: false, isSuccess: isSuccess);
  }
}
