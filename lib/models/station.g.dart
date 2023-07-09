// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Station _$StationFromJson(Map<String, dynamic> json) {
  return Station(
    id: json['stationId'] as int,
    name: json['stationName'] as String,
  );
}

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
