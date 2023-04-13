import 'package:flatiron/data/app_preferences.dart';
import 'package:flatiron/ui/floors/floors_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloorsViewModel extends StateNotifier<FloorsState> {
  FloorsViewModel(this._pref) : super(const FloorsState([], []));
  final AppPreferences _pref;

  void init() {
    final enableds = _pref.getEnabledFloors();
    final floors = _pref.getFloors();
    state = state.copyWith(isInit: false, floors: floors, enableds: enableds);
  }

  void selectOrDeselect(bool isSelected, String floor) {
    if (isSelected) {
      _select(floor);
    } else {
      _deselect(floor);
    }
  }

  void _select(String floor) async {
    final newFloors = state.enableds.toList()..add(floor);
    await _pref.saveEnabledFloors(newFloors);
    if (!mounted) return;
    state = state.copyWith(enableds: newFloors);
  }

  void _deselect(String floor) async {
    final newFloors = state.enableds.toList()..remove(floor);
    await _pref.saveEnabledFloors(newFloors);
    if (!mounted) return;
    state = state.copyWith(enableds: newFloors);
  }

  void selectAllOrDeselectAll() {
    if (state.hasSelection) {
      _deselectAll();
    } else {
      _selectAll();
    }
  }

  void _selectAll() async {
    final newFloors = state.floors.toList();
    await _pref.saveEnabledFloors(newFloors);
    if (!mounted) return;
    state = state.copyWith(enableds: newFloors);
  }

  void _deselectAll() async {
    final newFloors = List<String>.empty();
    await _pref.saveEnabledFloors(newFloors);
    if (!mounted) return;
    state = state.copyWith(enableds: newFloors);
  }
}
