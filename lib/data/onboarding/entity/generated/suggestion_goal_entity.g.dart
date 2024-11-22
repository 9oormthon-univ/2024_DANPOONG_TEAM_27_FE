// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../suggestion_goal_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestionGoalEntity _$SuggestionGoalEntityFromJson(
        Map<String, dynamic> json) =>
    SuggestionGoalEntity(
      goals: json['goals'] as String,
      period: json['period'] as String,
    );

Map<String, dynamic> _$SuggestionGoalEntityToJson(
        SuggestionGoalEntity instance) =>
    <String, dynamic>{
      'goals': instance.goals,
      'period': instance.period,
    };
