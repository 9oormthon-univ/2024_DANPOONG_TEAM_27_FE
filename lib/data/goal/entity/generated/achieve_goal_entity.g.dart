// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../achieve_goal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AchieveGoalEntity _$AchieveGoalEntityFromJson(Map<String, dynamic> json) =>
    AchieveGoalEntity(
      evolvedAnimals: (json['evolvedAnimals'] as num).toInt(),
      startDateYear: (json['start_date_year'] as num).toInt(),
      startDateMonth: (json['start_date_month'] as num).toInt(),
      startDateDay: (json['start_date_day'] as num).toInt(),
      endDateYear: (json['end_date_year'] as num).toInt(),
      endDateMonth: (json['end_date_month'] as num).toInt(),
      endDateDay: (json['end_date_day'] as num).toInt(),
      countSuccessTodo: (json['countSuccessTodo'] as num).toInt(),
      countAnimals: (json['countAnimals'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$AchieveGoalEntityToJson(AchieveGoalEntity instance) =>
    <String, dynamic>{
      'evolvedAnimals': instance.evolvedAnimals,
      'start_date_year': instance.startDateYear,
      'start_date_month': instance.startDateMonth,
      'start_date_day': instance.startDateDay,
      'end_date_year': instance.endDateYear,
      'end_date_month': instance.endDateMonth,
      'end_date_day': instance.endDateDay,
      'countSuccessTodo': instance.countSuccessTodo,
      'countAnimals': instance.countAnimals,
    };
