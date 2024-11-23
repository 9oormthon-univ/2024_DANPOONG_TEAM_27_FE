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
      categoryFortuneScores: (json['categoryFortuneScores'] as List<dynamic>)
          .map((e) =>
              CategoryFortuneScoresEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeOfDayFortuneScores: (json['timeOfDayFortuneScores'] as List<dynamic>)
          .map((e) =>
              TimeOfDayFortuneScoresEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
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

CategoryFortuneScoresEntity _$CategoryFortuneScoresEntityFromJson(
        Map<String, dynamic> json) =>
    CategoryFortuneScoresEntity(
      category: json['category'] as String,
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryFortuneScoresEntityToJson(
        CategoryFortuneScoresEntity instance) =>
    <String, dynamic>{
      'category': instance.category,
      'score': instance.score,
    };

TimeOfDayFortuneScoresEntity _$TimeOfDayFortuneScoresEntityFromJson(
        Map<String, dynamic> json) =>
    TimeOfDayFortuneScoresEntity(
      time: json['time'] as String,
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$TimeOfDayFortuneScoresEntityToJson(
        TimeOfDayFortuneScoresEntity instance) =>
    <String, dynamic>{
      'time': instance.time,
      'score': instance.score,
    };
