// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platechar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


PlateChar _$PlateCharFromJson(Map<String, dynamic> json) {
  return PlateChar(
    id: json['active'] as bool,
    name: json['plateChar'] as String,
  );
}

Map<String, dynamic> _$PlateCharToJson(PlateChar instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
