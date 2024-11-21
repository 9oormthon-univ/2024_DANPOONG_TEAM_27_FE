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
  final int startDateYear;
  final int startDateMonth;
  final int startDateDay;
  final int endDateYear;
  final int endDateMonth;
  final int endDateDay;

  factory CreateGoalRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateGoalRequestBodyFromJson(json);
}
