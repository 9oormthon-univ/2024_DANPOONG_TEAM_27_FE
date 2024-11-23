import 'package:json_annotation/json_annotation.dart';

part 'generated/achieve_goal_entity.g.dart';

@JsonSerializable()
class AchieveGoalEntity {
  final int evolvedAnimals;
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
  @JsonKey(name: 'countSuccessTodo')
  final int countSuccessTodo;
  @JsonKey(name: 'countAnimals')
  final List<int> countAnimals;

  const AchieveGoalEntity({
    required this.evolvedAnimals,
    required this.startDateYear,
    required this.startDateMonth,
    required this.startDateDay,
    required this.endDateYear,
    required this.endDateMonth,
    required this.endDateDay,
    required this.countSuccessTodo,
    required this.countAnimals,
  });

  factory AchieveGoalEntity.fromJson(Map<String, dynamic> json) =>
      _$AchieveGoalEntityFromJson(json);
}
