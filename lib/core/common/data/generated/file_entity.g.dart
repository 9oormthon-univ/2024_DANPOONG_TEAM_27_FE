// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../file_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileEntity _$FileEntityFromJson(Map<String, dynamic> json) => FileEntity(
      id: (json['id'] as num?)?.toInt(),
      logicalName: json['logicalName'] as String,
      physicalPath: json['physicalPath'] as String,
    );

Map<String, dynamic> _$FileEntityToJson(FileEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logicalName': instance.logicalName,
      'physicalPath': instance.physicalPath,
    };
