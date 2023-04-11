import 'package:flatiron/data/app_preferences.dart';
import 'package:flatiron/ui/home/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(this._pref) : super(const HomeState([]));

  final AppPreferences _pref;

  void init() async {
    state = state.copyWith(isInit: false);
    await _pref.initFloors();
    if (!mounted) return;
    state = state.copyWith(
      isInit: false,
      floors: _pref.getHomeFloors(),
      name: _pref.getFirstName(),
      mainFloor: _pref.getMainFloor(),
    );
  }

  void setMainFloor(String floor) {
    state = state.copyWith(mainFloor: floor);
  }

  void refreshFloors() {
    state = state.copyWith(floors: _pref.getHomeFloors());
  }
}
