// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../create_todo_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTodoRequestBody _$CreateTodoRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CreateTodoRequestBody(
      goalId: (json['goalId'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$CreateTodoRequestBodyToJson(
        CreateTodoRequestBody instance) =>
    <String, dynamic>{
      'goalId': instance.goalId,
      'name': instance.name,
    };
