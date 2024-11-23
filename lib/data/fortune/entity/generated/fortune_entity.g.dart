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
      categoryFortuneScores: CategoryFortuneScoresEntity.fromJson(
          json['categoryFortuneScores'] as Map<String, dynamic>),
      timeOfDayFortuneScores: TimeOfDayFortuneScoresEntity.fromJson(
          json['timeOfDayFortuneScores'] as Map<String, dynamic>),
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
      money: (json['Money'] as num).toInt(),
      study: (json['Study'] as num).toInt(),
      health: (json['Health'] as num).toInt(),
      love: (json['Love'] as num).toInt(),
      work: (json['Work'] as num).toInt(),
    );

Map<String, dynamic> _$CategoryFortuneScoresEntityToJson(
        CategoryFortuneScoresEntity instance) =>
    <String, dynamic>{
      'Money': instance.money,
      'Study': instance.study,
      'Health': instance.health,
      'Love': instance.love,
      'Work': instance.work,
    };

TimeOfDayFortuneScoresEntity _$TimeOfDayFortuneScoresEntityFromJson(
        Map<String, dynamic> json) =>
    TimeOfDayFortuneScoresEntity(
      morning: (json['Morning'] as num).toInt(),
      afternoon: (json['Afternoon'] as num).toInt(),
      night: (json['Night'] as num).toInt(),
    );

Map<String, dynamic> _$TimeOfDayFortuneScoresEntityToJson(
        TimeOfDayFortuneScoresEntity instance) =>
    <String, dynamic>{
      'Morning': instance.morning,
      'Afternoon': instance.afternoon,
      'Night': instance.night,
    };
