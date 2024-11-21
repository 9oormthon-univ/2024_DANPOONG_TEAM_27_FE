// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../login_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfoEntity _$LoginInfoEntityFromJson(Map<String, dynamic> json) =>
    LoginInfoEntity(
      email: json['email'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
    );

Map<String, dynamic> _$LoginInfoEntityToJson(LoginInfoEntity instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
    };
