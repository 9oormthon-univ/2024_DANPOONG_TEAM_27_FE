// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../create_goal_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGoalRequestBody _$CreateGoalRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CreateGoalRequestBody(
      name: json['name'] as String,
      startDateYear: (json['start_date_year'] as num).toInt(),
      startDateMonth: (json['start_date_month'] as num).toInt(),
      startDateDay: (json['start_date_day'] as num).toInt(),
      endDateYear: (json['end_date_year'] as num).toInt(),
      endDateMonth: (json['end_date_month'] as num).toInt(),
      endDateDay: (json['end_date_day'] as num).toInt(),
    );

Map<String, dynamic> _$CreateGoalRequestBodyToJson(
        CreateGoalRequestBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'start_date_year': instance.startDateYear,
      'start_date_month': instance.startDateMonth,
      'start_date_day': instance.startDateDay,
      'end_date_year': instance.endDateYear,
      'end_date_month': instance.endDateMonth,
      'end_date_day': instance.endDateDay,
    };
