import 'package:json_annotation/json_annotation.dart';

part 'generated/complete_goal_entity.g.dart';

@JsonSerializable()
class CompleteGoalEntity {
  final int goalId;
  final String name;
  final int countSuccessTodo;

  const CompleteGoalEntity({
    required this.goalId,
    required this.name,
    required this.countSuccessTodo,
  });

  factory CompleteGoalEntity.fromJson(Map<String, dynamic> json)
  => _$CompleteGoalEntityFromJson(json);
}
