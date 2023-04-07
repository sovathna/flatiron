import 'package:json_annotation/json_annotation.dart';

part 'floor.g.dart';

@JsonSerializable()
class FloorResponse {
  @JsonKey(name: "value")
  final String value;
  const FloorResponse({
    required this.value,
  });

  factory FloorResponse.fromJson(Map<String, dynamic> json) =>
      _$FloorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FloorResponseToJson(this);
}
