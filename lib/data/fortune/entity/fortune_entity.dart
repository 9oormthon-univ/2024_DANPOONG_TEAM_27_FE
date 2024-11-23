import 'package:json_annotation/json_annotation.dart';

part 'generated/fortune_entity.g.dart';

@JsonSerializable()
class FortuneEntity {
  const FortuneEntity({
    required this.fortuneKeywords,
    required this.shortFortune,
    required this.fullFortune,
    required this.categoryFortuneScores,
    required this.timeOfDayFortuneScores,
    required this.overallFortuneScore,
  });

  final List<String> fortuneKeywords;
  final String shortFortune;
  final String fullFortune;

  @JsonKey(name: 'categoryFortuneScores')
  final List<CategoryFortuneScoresEntity> categoryFortuneScores;

  @JsonKey(name: 'timeOfDayFortuneScores')
  final List<TimeOfDayFortuneScoresEntity> timeOfDayFortuneScores;

  final int overallFortuneScore;

  factory FortuneEntity.fromJson(Map<String, dynamic> json) =>
      _$FortuneEntityFromJson(json);
}

@JsonSerializable()
class CategoryFortuneScoresEntity {
  const CategoryFortuneScoresEntity({
    required this.category,
    required this.score,
  });

  final String category;
  final int score;

  factory CategoryFortuneScoresEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryFortuneScoresEntityFromJson(json);
}

@JsonSerializable()
class TimeOfDayFortuneScoresEntity {
  const TimeOfDayFortuneScoresEntity({
    required this.time,
    required this.score,
  });

  final String time;
  final int score;

  factory TimeOfDayFortuneScoresEntity.fromJson(Map<String, dynamic> json) =>
      _$TimeOfDayFortuneScoresEntityFromJson(json);
}
