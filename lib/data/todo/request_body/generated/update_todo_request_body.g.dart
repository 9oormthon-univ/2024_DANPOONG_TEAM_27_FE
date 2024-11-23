// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../update_todo_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTodoRequestBody _$UpdateTodoRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateTodoRequestBody(
      todoId: (json['todoId'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$UpdateTodoRequestBodyToJson(
        UpdateTodoRequestBody instance) =>
    <String, dynamic>{
      'todoId': instance.todoId,
      'name': instance.name,
    };
