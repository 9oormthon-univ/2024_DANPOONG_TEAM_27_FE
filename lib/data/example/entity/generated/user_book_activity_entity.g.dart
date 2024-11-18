// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_book_activity_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBookActivityEntity _$UserBookActivityEntityFromJson(
        Map<String, dynamic> json) =>
    UserBookActivityEntity(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      bookCount: (json['bookCount'] as num).toInt(),
      revuewCount: (json['revuewCount'] as num).toInt(),
      bookResponses: (json['bookResponses'] as List<dynamic>)
          .map((e) => BookEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserBookActivityEntityToJson(
        UserBookActivityEntity instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'bookCount': instance.bookCount,
      'revuewCount': instance.revuewCount,
      'bookResponses': instance.bookResponses,
    };
