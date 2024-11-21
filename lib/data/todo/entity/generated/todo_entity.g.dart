// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../todo_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoEntity _$TodoEntityFromJson(Map<String, dynamic> json) => TodoEntity(
      todoId: (json['todoId'] as num).toInt(),
      name: json['name'] as String,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$TodoEntityToJson(TodoEntity instance) =>
    <String, dynamic>{
      'todoId': instance.todoId,
      'name': instance.name,
      'isCompleted': instance.isCompleted,
    };
