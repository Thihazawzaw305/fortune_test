// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      (json['userId'] as num).toInt(),
      json['username'] as String,
      json['password'] as String,
      json['profilePhoto'] as String?,
      json['role'] as String?,
      json['profilePhotoLink'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'userId': instance.userId,
      'username': instance.userName,
      'password': instance.password,
      'role': instance.role,
      'profilePhoto': instance.profilePhoto,
      'profilePhotoLink': instance.profilePhotoLink,
    };
