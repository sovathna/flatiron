import 'package:flatiron/model/floor.dart';
import 'package:flutter/material.dart';

@immutable
class FloorState {
  final bool isInit;
  final FloorResponse? data;
  final bool isLoading;
  final String error;
  final int elapse;

  const FloorState({
    this.isInit = true,
    this.data,
    this.isLoading = false,
    this.error = "",
    this.elapse = 0,
  });

  FloorState copyWith(
      {bool? isInit,
      bool? isLoading,
      FloorResponse? data,
      String? error,
      int? elapse}) {
    return FloorState(
      isInit: isInit ?? this.isInit,
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
      elapse: elapse ?? this.elapse,
    );
  }

  bool get hasValue => data?.value.isNotEmpty == true;
}
