import 'dart:collection';

import 'package:flutter/material.dart';

@immutable
class FloorsState {
  final bool isInit;

  final List<String> _floors;
  UnmodifiableListView<String> get floors =>
      UnmodifiableListView<String>(_floors);

  final List<String> _enableds;
  UnmodifiableListView<String> get enableds =>
      UnmodifiableListView<String>(_enableds);

  const FloorsState(
    this._floors,
    this._enableds, {
    this.isInit = true,
  });

  FloorsState copyWith({
    bool? isInit,
    List<String>? floors,
    List<String>? enableds,
  }) {
    return FloorsState(
      floors ?? _floors,
      enableds ?? _enableds,
      isInit: isInit ?? this.isInit,
    );
  }
}
