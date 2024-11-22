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
  final Map<String, int> categoryFortuneScores;
  
  @JsonKey(name: 'timeOfDayFortuneScores')
  final Map<String, int> timeOfDayFortuneScores;
  
  final int overallFortuneScore;

  factory FortuneEntity.fromJson(Map<String, dynamic> json) =>
      _$FortuneEntityFromJson(json);
  
}
