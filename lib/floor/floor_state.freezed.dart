// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FloorState {
  bool get isInit => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  Uint8List? get imageData => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FloorStateCopyWith<FloorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloorStateCopyWith<$Res> {
  factory $FloorStateCopyWith(
          FloorState value, $Res Function(FloorState) then) =
      _$FloorStateCopyWithImpl<$Res, FloorState>;
  @useResult
  $Res call(
      {bool isInit,
      String? value,
      Uint8List? imageData,
      bool isLoading,
      String? error});
}

/// @nodoc
class _$FloorStateCopyWithImpl<$Res, $Val extends FloorState>
    implements $FloorStateCopyWith<$Res> {
  _$FloorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInit = null,
    Object? value = freezed,
    Object? imageData = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isInit: null == isInit
          ? _value.isInit
          : isInit // ignore: cast_nullable_to_non_nullable
              as bool,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      imageData: freezed == imageData
          ? _value.imageData
          : imageData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FloorStateCopyWith<$Res>
    implements $FloorStateCopyWith<$Res> {
  factory _$$_FloorStateCopyWith(
          _$_FloorState value, $Res Function(_$_FloorState) then) =
      __$$_FloorStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isInit,
      String? value,
      Uint8List? imageData,
      bool isLoading,
      String? error});
}

/// @nodoc
class __$$_FloorStateCopyWithImpl<$Res>
    extends _$FloorStateCopyWithImpl<$Res, _$_FloorState>
    implements _$$_FloorStateCopyWith<$Res> {
  __$$_FloorStateCopyWithImpl(
      _$_FloorState _value, $Res Function(_$_FloorState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInit = null,
    Object? value = freezed,
    Object? imageData = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$_FloorState(
      isInit: null == isInit
          ? _value.isInit
          : isInit // ignore: cast_nullable_to_non_nullable
              as bool,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      imageData: freezed == imageData
          ? _value.imageData
          : imageData // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_FloorState implements _FloorState {
  _$_FloorState(
      {this.isInit = true,
      this.value,
      this.imageData,
      this.isLoading = false,
      this.error});

  @override
  @JsonKey()
  final bool isInit;
  @override
  final String? value;
  @override
  final Uint8List? imageData;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'FloorState(isInit: $isInit, value: $value, imageData: $imageData, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FloorState &&
            (identical(other.isInit, isInit) || other.isInit == isInit) &&
            (identical(other.value, value) || other.value == value) &&
            const DeepCollectionEquality().equals(other.imageData, imageData) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isInit, value,
      const DeepCollectionEquality().hash(imageData), isLoading, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FloorStateCopyWith<_$_FloorState> get copyWith =>
      __$$_FloorStateCopyWithImpl<_$_FloorState>(this, _$identity);
}

abstract class _FloorState implements FloorState {
  factory _FloorState(
      {final bool isInit,
      final String? value,
      final Uint8List? imageData,
      final bool isLoading,
      final String? error}) = _$_FloorState;

  @override
  bool get isInit;
  @override
  String? get value;
  @override
  Uint8List? get imageData;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$_FloorStateCopyWith<_$_FloorState> get copyWith =>
      throw _privateConstructorUsedError;
}
