// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../goal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalEntity _$GoalEntityFromJson(Map<String, dynamic> json) => GoalEntity(
      isCompleted: json['isCompleted'] as bool,
      startDateYear: (json['startDateYear'] as num).toInt(),
      startDateMonth: (json['startDateMonth'] as num).toInt(),
      startDateDay: (json['startDateDay'] as num).toInt(),
      endDateYear: (json['endDateYear'] as num).toInt(),
      endDateMonth: (json['endDateMonth'] as num).toInt(),
      endDateDay: (json['endDateDay'] as num).toInt(),
      goalId: (json['goalId'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$GoalEntityToJson(GoalEntity instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'name': instance.name,
      'isCompleted': instance.isCompleted,
      'startDateYear': instance.startDateYear,
      'startDateMonth': instance.startDateMonth,
      'startDateDay': instance.startDateDay,
      'endDateYear': instance.endDateYear,
      'endDateMonth': instance.endDateMonth,
      'endDateDay': instance.endDateDay,
    };
