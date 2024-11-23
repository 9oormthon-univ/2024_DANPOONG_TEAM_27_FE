import 'package:equatable/equatable.dart';

import '../../../data/todo/entity/todo_entity.dart';

class TodoModel extends Equatable {
  final int todoId;
  final String name;
  final bool isCompleted;
  final bool isMadeByGpt;
  final String fortuneType;
  final int score;
  final int animal;

  const TodoModel({
    required this.todoId,
    required this.name,
    required this.isCompleted,
    required this.isMadeByGpt,
    required this.fortuneType,
    required this.score,
    required this.animal,
  });

  factory TodoModel.fromEntity({
    required TodoEntity entity,
  }) =>
      TodoModel(
        todoId: entity.todoId,
        name: entity.name,
        isCompleted: entity.isCompleted,
        isMadeByGpt: entity.isMadeByGpt,
        fortuneType: entity.fortuneType,
        score: entity.score,
        animal: entity.animal,
      );

  TodoModel copyWith({
    int? todoId,
    String? name,
    bool? isCompleted,
    bool? isMadeByGpt,
    String? fortuneType,
    int? score,
    int? animal,
  }) =>
      TodoModel(
        todoId: todoId ?? this.todoId,
        name: name ?? this.name,
        isCompleted: isCompleted ?? this.isCompleted,
        isMadeByGpt: isMadeByGpt ?? this.isMadeByGpt,
        fortuneType: fortuneType ?? this.fortuneType,
        score: score ?? this.score,
        animal: animal ?? this.animal,
      );

  @override
  List<Object?> get props => <Object?>[
        todoId,
        name,
        isCompleted,
        isMadeByGpt,
        fortuneType,
        score,
        animal,
      ];
}
