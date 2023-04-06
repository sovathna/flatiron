// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FloorResponse _$FloorResponseFromJson(Map<String, dynamic> json) {
  return _FloorResponse.fromJson(json);
}

/// @nodoc
mixin _$FloorResponse {
  @JsonKey(name: "imgPath")
  String get imageData => throw _privateConstructorUsedError;
  @JsonKey(name: "value")
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FloorResponseCopyWith<FloorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloorResponseCopyWith<$Res> {
  factory $FloorResponseCopyWith(
          FloorResponse value, $Res Function(FloorResponse) then) =
      _$FloorResponseCopyWithImpl<$Res, FloorResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "imgPath") String imageData,
      @JsonKey(name: "value") String value});
}

/// @nodoc
class _$FloorResponseCopyWithImpl<$Res, $Val extends FloorResponse>
    implements $FloorResponseCopyWith<$Res> {
  _$FloorResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageData = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      imageData: null == imageData
          ? _value.imageData
          : imageData // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FloorResponseCopyWith<$Res>
    implements $FloorResponseCopyWith<$Res> {
  factory _$$_FloorResponseCopyWith(
          _$_FloorResponse value, $Res Function(_$_FloorResponse) then) =
      __$$_FloorResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "imgPath") String imageData,
      @JsonKey(name: "value") String value});
}

/// @nodoc
class __$$_FloorResponseCopyWithImpl<$Res>
    extends _$FloorResponseCopyWithImpl<$Res, _$_FloorResponse>
    implements _$$_FloorResponseCopyWith<$Res> {
  __$$_FloorResponseCopyWithImpl(
      _$_FloorResponse _value, $Res Function(_$_FloorResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageData = null,
    Object? value = null,
  }) {
    return _then(_$_FloorResponse(
      imageData: null == imageData
          ? _value.imageData
          : imageData // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FloorResponse implements _FloorResponse {
  _$_FloorResponse(
      {@JsonKey(name: "imgPath") required this.imageData,
      @JsonKey(name: "value") required this.value});

  factory _$_FloorResponse.fromJson(Map<String, dynamic> json) =>
      _$$_FloorResponseFromJson(json);

  @override
  @JsonKey(name: "imgPath")
  final String imageData;
  @override
  @JsonKey(name: "value")
  final String value;

  @override
  String toString() {
    return 'FloorResponse(imageData: $imageData, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FloorResponse &&
            (identical(other.imageData, imageData) ||
                other.imageData == imageData) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, imageData, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FloorResponseCopyWith<_$_FloorResponse> get copyWith =>
      __$$_FloorResponseCopyWithImpl<_$_FloorResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FloorResponseToJson(
      this,
    );
  }
}

abstract class _FloorResponse implements FloorResponse {
  factory _FloorResponse(
      {@JsonKey(name: "imgPath") required final String imageData,
      @JsonKey(name: "value") required final String value}) = _$_FloorResponse;

  factory _FloorResponse.fromJson(Map<String, dynamic> json) =
      _$_FloorResponse.fromJson;

  @override
  @JsonKey(name: "imgPath")
  String get imageData;
  @override
  @JsonKey(name: "value")
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$_FloorResponseCopyWith<_$_FloorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
