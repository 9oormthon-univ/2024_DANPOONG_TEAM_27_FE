import 'package:json_annotation/json_annotation.dart';
part 'generated/todo_entity.g.dart';

@JsonSerializable()
class TodoEntity {
  const TodoEntity({
    required this.todoId,
    required this.name,
    required this.year,
    required this.month,
    required this.day,
    required this.isCompleted,
  });

  final int todoId;
  final String name;
  final int year;
  final int month;
  final int day;
  final bool isCompleted;

  factory TodoEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoEntityFromJson(json);
}
