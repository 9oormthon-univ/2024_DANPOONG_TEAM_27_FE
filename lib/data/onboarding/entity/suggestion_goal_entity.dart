import 'package:json_annotation/json_annotation.dart';

part 'generated/suggestion_goal_entity.g.dart';

@JsonSerializable()
class SuggestionGoalEntity {
  const SuggestionGoalEntity({
    required this.goals,
    required this.period,
  });

  final String goals;
  final String period;

  factory SuggestionGoalEntity.fromJson(Map<String, dynamic> json) =>
      _$SuggestionGoalEntityFromJson(json);
}
