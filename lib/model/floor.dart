import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'floor.g.dart';

@immutable
@JsonSerializable()
class FloorResponse {
  @JsonKey(name: "value")
  final String value;
  @JsonKey(name: "imgPath")
  final String imageData;
  const FloorResponse({required this.value, required this.imageData});

  factory FloorResponse.fromJson(Map<String, dynamic> json) =>
      _$FloorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FloorResponseToJson(this);
}
