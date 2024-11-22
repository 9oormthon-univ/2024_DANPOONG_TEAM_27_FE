// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../auth_token_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokenEntity _$AuthTokenEntityFromJson(Map<String, dynamic> json) =>
    AuthTokenEntity(
      data: TokenData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthTokenEntityToJson(AuthTokenEntity instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

TokenData _$TokenDataFromJson(Map<String, dynamic> json) => TokenData(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$TokenDataToJson(TokenData instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
