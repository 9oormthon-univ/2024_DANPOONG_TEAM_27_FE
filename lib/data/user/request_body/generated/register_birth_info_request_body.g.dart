// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../register_birth_info_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterBirthInfoRequestBody _$RegisterBirthInfoRequestBodyFromJson(
        Map<String, dynamic> json) =>
    RegisterBirthInfoRequestBody(
      gender: json['gender'] as String,
      solarOrLunar: json['solarOrLunar'] as String,
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      day: (json['day'] as num).toInt(),
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
      unknownTime: json['unknownTime'] as bool,
    );

Map<String, dynamic> _$RegisterBirthInfoRequestBodyToJson(
        RegisterBirthInfoRequestBody instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'solarOrLunar': instance.solarOrLunar,
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'hour': instance.hour,
      'minute': instance.minute,
      'unknownTime': instance.unknownTime,
    };
