// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../goal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalEntity _$GoalEntityFromJson(Map<String, dynamic> json) => GoalEntity(
      isCompleted: json['isCompleted'] as bool,
      startDateYear: (json['start_date_year'] as num).toInt(),
      startDateMonth: (json['start_date_month'] as num).toInt(),
      startDateDay: (json['start_date_day'] as num).toInt(),
      endDateYear: (json['end_date_year'] as num).toInt(),
      endDateMonth: (json['end_date_month'] as num).toInt(),
      endDateDay: (json['end_date_day'] as num).toInt(),
      goalId: (json['goalId'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$GoalEntityToJson(GoalEntity instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'name': instance.name,
      'isCompleted': instance.isCompleted,
      'start_date_year': instance.startDateYear,
      'start_date_month': instance.startDateMonth,
      'start_date_day': instance.startDateDay,
      'end_date_year': instance.endDateYear,
      'end_date_month': instance.endDateMonth,
      'end_date_day': instance.endDateDay,
    };
