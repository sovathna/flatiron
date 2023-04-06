import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'floor_state.freezed.dart';

@Freezed()
class FloorState with _$FloorState {
  factory FloorState({
    @Default(true) bool isInit,
    String? value,
    Uint8List? imageData,
    @Default(false) bool isLoading,
    String? error,
  }) = _FloorState;
}
