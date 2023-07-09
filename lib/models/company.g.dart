// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    id: json['companyID'] as int,
    name: json['companyName'] as String,
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
