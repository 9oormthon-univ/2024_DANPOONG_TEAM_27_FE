// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../complete_goal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteGoalEntity _$CompleteGoalEntityFromJson(Map<String, dynamic> json) =>
    CompleteGoalEntity(
      goalId: (json['goalId'] as num).toInt(),
      name: json['name'] as String,
      countSuccessTodo: (json['countSuccessTodo'] as num).toInt(),
    );

Map<String, dynamic> _$CompleteGoalEntityToJson(CompleteGoalEntity instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'name': instance.name,
      'countSuccessTodo': instance.countSuccessTodo,
    };
