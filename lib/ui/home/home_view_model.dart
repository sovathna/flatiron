import 'package:flatiron/data/app_preferences.dart';
import 'package:flatiron/ui/home/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(this._pref) : super(const HomeState([]));

  final AppPreferences _pref;

  void init() {
    state = state.copyWith(
      isInit: false,
      floors: _pref.getFloors(),
      name: _pref.getFirstName(),
      mainFloor: _pref.getMainFloor(),
    );
  }

  void setMainFloor(String floor) {
    state = state.copyWith(mainFloor: floor);
  }
}
