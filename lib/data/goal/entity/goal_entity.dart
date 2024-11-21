import 'package:json_annotation/json_annotation.dart';
part 'generated/goal_entity.g.dart';

@JsonSerializable()
class GoalEntity {
  const GoalEntity({
    required this.isCompleted,
    required this.startDateYear,
    required this.startDateMonth,
    required this.startDateDay,
    required this.endDateYear,
    required this.endDateMonth,
    required this.endDateDay,
    required this.goalId,
    required this.name,
  });

  final int goalId;
  final String name;
  final bool isCompleted;
  final int startDateYear;
  final int startDateMonth;
  final int startDateDay;
  final int endDateYear;
  final int endDateMonth;
  final int endDateDay;

  factory GoalEntity.fromJson(Map<String, dynamic> json) =>
      _$GoalEntityFromJson(json);
}
