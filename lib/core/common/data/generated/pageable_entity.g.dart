// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../pageable_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageableEntity _$PageableEntityFromJson(Map<String, dynamic> json) =>
    PageableEntity(
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalElements: (json['totalElements'] as num).toInt(),
      isEnd: json['isEnd'] as bool,
    );

Map<String, dynamic> _$PageableEntityToJson(PageableEntity instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'isEnd': instance.isEnd,
    };
