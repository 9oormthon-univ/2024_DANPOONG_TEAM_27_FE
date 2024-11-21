import 'package:json_annotation/json_annotation.dart';
part 'generated/create_todo_request_body.g.dart';

@JsonSerializable()
class CreateTodoRequestBody {
  const CreateTodoRequestBody({
    required this.goalId,
    required this.name,
  });

  final int goalId;
  final String name;

  factory CreateTodoRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateTodoRequestBodyFromJson(json);
}
