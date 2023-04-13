// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorResponse _$FloorResponseFromJson(Map<String, dynamic> json) =>
    FloorResponse(
      value: json['value'] as String,
      imageData: json['imgPath'] as String,
    );

Map<String, dynamic> _$FloorResponseToJson(FloorResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'imgPath': instance.imageData,
    };
