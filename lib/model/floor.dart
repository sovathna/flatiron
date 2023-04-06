import 'package:freezed_annotation/freezed_annotation.dart';

part 'floor.freezed.dart';
part 'floor.g.dart';

@Freezed()
class FloorResponse with _$FloorResponse {
  factory FloorResponse({
    @JsonKey(name: "imgPath") required String imageData,
    @JsonKey(name: "value") required String value,
  }) = _FloorResponse;

  factory FloorResponse.fromJson(Map<String, dynamic> json) =>
      _$FloorResponseFromJson(json);
}
