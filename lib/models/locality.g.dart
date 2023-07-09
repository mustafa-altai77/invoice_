// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Locality _$LocalityFromJson(Map<String, dynamic> json) {
  return Locality(
    id: json['localityId'] as int,
    name: json['localityName'] as String,
  );
}

Map<String, dynamic> _$LocalityToJson(Locality instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
