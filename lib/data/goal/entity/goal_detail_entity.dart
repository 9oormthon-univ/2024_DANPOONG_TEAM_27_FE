import 'package:json_annotation/json_annotation.dart';

part 'generated/goal_detail_entity.g.dart';

@JsonSerializable()
class GoalDetailEntity {
  const GoalDetailEntity({
    required this.startDateYear,
    required this.startDateMonth,
    required this.startDateDay,
    required this.endDateYear,
    required this.endDateMonth,
    required this.endDateDay,
    required this.countAnimals,
  });

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

  @JsonKey(name: 'countAnimals')
  final List<int> countAnimals;

  factory GoalDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$GoalDetailEntityFromJson(json);
}
