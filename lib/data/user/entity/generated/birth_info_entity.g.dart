// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../birth_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BirthInfoEntity _$BirthInfoEntityFromJson(Map<String, dynamic> json) =>
    BirthInfoEntity(
      gender: json['gender'] as String,
      solarOrLunar: json['solarOrLunar'] as String,
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      day: (json['day'] as num).toInt(),
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
    );

Map<String, dynamic> _$BirthInfoEntityToJson(BirthInfoEntity instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'solarOrLunar': instance.solarOrLunar,
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'hour': instance.hour,
      'minute': instance.minute,
    };
