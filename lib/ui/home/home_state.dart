import 'dart:collection';

import 'package:flutter/material.dart';

@immutable
class HomeState {
  final bool isInit;
  final String? name;
  final String? mainFloor;
  final List<String> _floors;
  UnmodifiableListView get floors => UnmodifiableListView(_floors);

  const HomeState(
    this._floors, {
    this.isInit = true,
    this.name,
    this.mainFloor,
  });

  HomeState copyWith({
    bool? isInit,
    List<String>? floors,
    String? name,
    String? mainFloor,
  }) {
    return HomeState(
      floors ?? _floors,
      isInit: isInit ?? this.isInit,
      name: name ?? this.name,
      mainFloor: mainFloor ?? this.mainFloor,
    );
  }

  bool get hasData =>
      name?.isNotEmpty == true &&
      mainFloor?.isNotEmpty == true &&
      _floors.isNotEmpty;
}
