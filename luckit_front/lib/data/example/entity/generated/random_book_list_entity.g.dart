// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../random_book_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RandomBookListEntity _$RandomBookListEntityFromJson(
        Map<String, dynamic> json) =>
    RandomBookListEntity(
      contents: (json['contents'] as List<dynamic>)
          .map((e) => BookEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RandomBookListEntityToJson(
        RandomBookListEntity instance) =>
    <String, dynamic>{
      'contents': instance.contents,
    };
