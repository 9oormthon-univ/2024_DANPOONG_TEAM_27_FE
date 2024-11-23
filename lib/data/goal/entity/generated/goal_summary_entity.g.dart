// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../goal_summary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalSummaryEntity _$GoalSummaryEntityFromJson(Map<String, dynamic> json) =>
    GoalSummaryEntity(
      goalId: (json['goalId'] as num).toInt(),
      name: json['name'] as String,
      countSuccessTodo: (json['countSuccessTodo'] as num).toInt(),
    );

Map<String, dynamic> _$GoalSummaryEntityToJson(GoalSummaryEntity instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'name': instance.name,
      'countSuccessTodo': instance.countSuccessTodo,
    };
