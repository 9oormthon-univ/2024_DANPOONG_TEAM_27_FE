// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../entity_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntityForm<T> _$EntityFormFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    EntityForm<T>(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$EntityFormToJson<T>(
  EntityForm<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': toJsonT(instance.data),
    };
