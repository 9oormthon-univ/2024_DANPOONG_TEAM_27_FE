// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../example_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleEntity _$ExampleEntityFromJson(Map<String, dynamic> json) =>
    ExampleEntity(
      id: json['id'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$ExampleEntityToJson(ExampleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
