// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../list_entity_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListEntityForm<T> _$ListEntityFormFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ListEntityForm<T>(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ListEntityFormToJson<T>(
  ListEntityForm<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data.map(toJsonT).toList(),
    };
