// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../todo_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoEntity _$TodoEntityFromJson(Map<String, dynamic> json) => TodoEntity(
      todoId: (json['todoId'] as num).toInt(),
      name: json['name'] as String,
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      day: (json['day'] as num).toInt(),
      isCompleted: json['isCompleted'] as bool,
      isMadeByGpt: json['isMadeByGpt'] as bool,
      fortuneType: json['fortuneType'] as String,
      score: (json['score'] as num).toInt(),
      animal: (json['animal'] as num).toInt(),
    );

Map<String, dynamic> _$TodoEntityToJson(TodoEntity instance) =>
    <String, dynamic>{
      'todoId': instance.todoId,
      'name': instance.name,
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'isCompleted': instance.isCompleted,
      'isMadeByGpt': instance.isMadeByGpt,
      'fortuneType': instance.fortuneType,
      'score': instance.score,
      'animal': instance.animal,
    };
