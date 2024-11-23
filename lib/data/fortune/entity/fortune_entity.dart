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
  final CategoryFortuneScoresEntity categoryFortuneScores;

  @JsonKey(name: 'timeOfDayFortuneScores')
  final TimeOfDayFortuneScoresEntity timeOfDayFortuneScores;

  final int overallFortuneScore;

  factory FortuneEntity.fromJson(Map<String, dynamic> json) =>
      _$FortuneEntityFromJson(json);
}

@JsonSerializable()
class CategoryFortuneScoresEntity {
  const CategoryFortuneScoresEntity({
    required this.money,
    required this.study,
    required this.health,
    required this.love,
    required this.work,
  });

  @JsonKey(name: 'Money')
  final int money;

  @JsonKey(name: 'Study')
  final int study;

  @JsonKey(name: 'Health')
  final int health;

  @JsonKey(name: 'Love')
  final int love;

  @JsonKey(name: 'Work')
  final int work;

  factory CategoryFortuneScoresEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryFortuneScoresEntityFromJson(json);
}

@JsonSerializable()
class TimeOfDayFortuneScoresEntity {
  const TimeOfDayFortuneScoresEntity({
    required this.morning,
    required this.afternoon,
    required this.night,
  });

  @JsonKey(name: 'Morning')
  final int morning;

  @JsonKey(name: 'Afternoon')
  final int afternoon;

  @JsonKey(name: 'Night')
  final int night;

  factory TimeOfDayFortuneScoresEntity.fromJson(Map<String, dynamic> json) =>
      _$TimeOfDayFortuneScoresEntityFromJson(json);
}
