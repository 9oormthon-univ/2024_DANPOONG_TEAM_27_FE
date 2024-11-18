// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../book_search_result_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookSearchResultEntity _$BookSearchResultEntityFromJson(
        Map<String, dynamic> json) =>
    BookSearchResultEntity(
      contents: (json['contents'] as List<dynamic>)
          .map((e) => BookEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageable:
          PageableEntity.fromJson(json['pageable'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookSearchResultEntityToJson(
        BookSearchResultEntity instance) =>
    <String, dynamic>{
      'contents': instance.contents,
      'pageable': instance.pageable,
    };
