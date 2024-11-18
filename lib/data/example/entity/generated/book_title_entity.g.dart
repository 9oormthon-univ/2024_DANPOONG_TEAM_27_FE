// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../book_title_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookTitleEntity _$BookTitleEntityFromJson(Map<String, dynamic> json) =>
    BookTitleEntity(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
    );

Map<String, dynamic> _$BookTitleEntityToJson(BookTitleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
