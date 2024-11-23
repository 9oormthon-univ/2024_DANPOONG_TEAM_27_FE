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
    required this.isMadeByGpt,
    required this.fortuneType,
    required this.score,
    required this.animal,
  });

  final int todoId;
  final String name;
  final int year;
  final int month;
  final int day;
  final bool isCompleted;
  final bool isMadeByGpt;
  final String fortuneType;
  final int score;
  final int animal;

  factory TodoEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoEntityFromJson(json);
}
