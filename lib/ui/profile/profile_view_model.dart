import 'package:flatiron/data/app_preferences.dart';
import 'package:flatiron/ui/profile/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel(this._pref) : super(const ProfileState());

  final AppPreferences _pref;
  void init() {
    state = state.copyWith(
      isInit: false,
      name: _pref.getName(),
      phone: _mask(_pref.getPhone()),
    );
  }

  String _mask(String phone) {
    final start = phone.substring(0, 3);
    final end = phone.substring(phone.length - 2);
    return phone.length == 9 ? "$start****$end" : "$start*****$end";
  }

  void logout() {
    _pref.clear();
  }
}
