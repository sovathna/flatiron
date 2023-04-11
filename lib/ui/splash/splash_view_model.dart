import 'package:flatiron/data/app_preferences.dart';
import 'package:flatiron/ui/splash/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel(this._pref) : super(const SplashState());

  final AppPreferences _pref;

  void init() {
    state = state.copyWith(isInit: false, isLoading: true);
    if (!mounted) return;
    state = state.copyWith(isLoading: false, isSuccess: _pref.hasData());
  }
}
