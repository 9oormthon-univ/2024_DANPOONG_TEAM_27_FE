// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../fortune_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FortuneEntity _$FortuneEntityFromJson(Map<String, dynamic> json) =>
    FortuneEntity(
      fortuneKeywords: (json['fortuneKeywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      shortFortune: json['shortFortune'] as String,
      fullFortune: json['fullFortune'] as String,
      categoryFortuneScores:
          Map<String, int>.from(json['categoryFortuneScores'] as Map),
      timeOfDayFortuneScores:
          Map<String, int>.from(json['timeOfDayFortuneScores'] as Map),
      overallFortuneScore: (json['overallFortuneScore'] as num).toInt(),
    );

Map<String, dynamic> _$FortuneEntityToJson(FortuneEntity instance) =>
    <String, dynamic>{
      'fortuneKeywords': instance.fortuneKeywords,
      'shortFortune': instance.shortFortune,
      'fullFortune': instance.fullFortune,
      'categoryFortuneScores': instance.categoryFortuneScores,
      'timeOfDayFortuneScores': instance.timeOfDayFortuneScores,
      'overallFortuneScore': instance.overallFortuneScore,
    };
