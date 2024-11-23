import 'package:json_annotation/json_annotation.dart';
part 'generated/goal_summary_entity.g.dart';

@JsonSerializable()
class GoalSummaryEntity {
  const GoalSummaryEntity({
    required this.goalId,
    required this.name,
    required this.countSuccessTodo,
  });

  final int goalId;
  final String name;
  final int countSuccessTodo;

  factory GoalSummaryEntity.fromJson(Map<String, dynamic> json) =>
      _$GoalSummaryEntityFromJson(json);
}
