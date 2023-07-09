// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['profileName'] as String,
    username: json['idNumber'] as String,
    banner: json['phone'] as String,
    description: json['stateName'] as String,
    email: 'ana@gmail.com',//json['email'] as String,
    avatar: json['profileName'] as String,
    createdAt: json['registerDate'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    followsCount: json['countCarNew'] as int,
    followersCount: json['countCarReject'] as int,
    isFollowed: json['countCarReject'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'avatar': instance.avatar,
      'banner': instance.banner,
      'description': instance.description,
      'email': instance.email,
      'created_at': instance.createdAt?.toIso8601String(),
      'follows_count': instance.followsCount,
      'followers_count': instance.followersCount,
      'is_followed': instance.isFollowed,
    };
