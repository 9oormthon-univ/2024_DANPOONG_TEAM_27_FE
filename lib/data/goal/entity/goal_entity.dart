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
  @JsonKey(name: 'start_date_year')
  final int startDateYear;
  @JsonKey(name: 'start_date_month')
  final int startDateMonth;
  @JsonKey(name: 'start_date_day')
  final int startDateDay;
  @JsonKey(name: 'end_date_year')
  final int endDateYear;
  @JsonKey(name: 'end_date_month')
  final int endDateMonth;
  @JsonKey(name: 'end_date_day')
  final int endDateDay;

  factory GoalEntity.fromJson(Map<String, dynamic> json) =>
      _$GoalEntityFromJson(json);
}
