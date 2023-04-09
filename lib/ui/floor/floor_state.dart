import 'package:flutter/material.dart';

@immutable
class FloorState {
  final bool isInit;
  final String value;
  final bool isLoading;
  final String error;
  final int elapse;

  const FloorState({
    this.isInit = true,
    this.value = "",
    this.isLoading = false,
    this.error = "",
    this.elapse = 0,
  });

  FloorState copyWith(
      {bool? isInit,
      bool? isLoading,
      String? value,
      String? error,
      int? elapse}) {
    return FloorState(
      isInit: isInit ?? this.isInit,
      isLoading: isLoading ?? this.isLoading,
      value: value ?? this.value,
      error: error ?? this.error,
      elapse: elapse ?? this.elapse,
    );
  }
}
