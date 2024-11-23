import 'package:json_annotation/json_annotation.dart';
part 'generated/create_goal_request_body.g.dart';

@JsonSerializable()
class CreateGoalRequestBody {
  const CreateGoalRequestBody({
    required this.name,
    required this.startDateYear,
    required this.startDateMonth,
    required this.startDateDay,
    required this.endDateYear,
    required this.endDateMonth,
    required this.endDateDay,
  });

  final String name;

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

  Map<String, dynamic> toJson() => _$CreateGoalRequestBodyToJson(this);

  factory CreateGoalRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateGoalRequestBodyFromJson(json);
}
