// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../goal_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalDetailEntity _$GoalDetailEntityFromJson(Map<String, dynamic> json) =>
    GoalDetailEntity(
      startDateYear: (json['start_date_year'] as num).toInt(),
      startDateMonth: (json['start_date_month'] as num).toInt(),
      startDateDay: (json['start_date_day'] as num).toInt(),
      endDateYear: (json['end_date_year'] as num).toInt(),
      endDateMonth: (json['end_date_month'] as num).toInt(),
      endDateDay: (json['end_date_day'] as num).toInt(),
      countAnimals: (json['countAnimals'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$GoalDetailEntityToJson(GoalDetailEntity instance) =>
    <String, dynamic>{
      'start_date_year': instance.startDateYear,
      'start_date_month': instance.startDateMonth,
      'start_date_day': instance.startDateDay,
      'end_date_year': instance.endDateYear,
      'end_date_month': instance.endDateMonth,
      'end_date_day': instance.endDateDay,
      'countAnimals': instance.countAnimals,
    };
