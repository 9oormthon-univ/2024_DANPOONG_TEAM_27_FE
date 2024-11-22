// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../create_goal_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGoalRequestBody _$CreateGoalRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CreateGoalRequestBody(
      name: json['name'] as String,
      startDateYear: (json['startDateYear'] as num).toInt(),
      startDateMonth: (json['startDateMonth'] as num).toInt(),
      startDateDay: (json['startDateDay'] as num).toInt(),
      endDateYear: (json['endDateYear'] as num).toInt(),
      endDateMonth: (json['endDateMonth'] as num).toInt(),
      endDateDay: (json['endDateDay'] as num).toInt(),
    );

Map<String, dynamic> _$CreateGoalRequestBodyToJson(
        CreateGoalRequestBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'startDateYear': instance.startDateYear,
      'startDateMonth': instance.startDateMonth,
      'startDateDay': instance.startDateDay,
      'endDateYear': instance.endDateYear,
      'endDateMonth': instance.endDateMonth,
      'endDateDay': instance.endDateDay,
    };
