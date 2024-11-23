import 'package:json_annotation/json_annotation.dart';
part 'generated/update_todo_request_body.g.dart';

@JsonSerializable()
class UpdateTodoRequestBody {
  const UpdateTodoRequestBody({
    required this.todoId,
    required this.name,
  });

  final int todoId;
  final String name;

  factory UpdateTodoRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateTodoRequestBodyFromJson(json);
}
