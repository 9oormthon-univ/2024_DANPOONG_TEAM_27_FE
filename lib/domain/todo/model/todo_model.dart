import 'package:equatable/equatable.dart';

import '../../../data/todo/entity/todo_entity.dart';

class TodoModel extends Equatable {
  final int todoId;
  final String name;
  final bool isCompleted;

  const TodoModel({
    required this.todoId,
    required this.name,
    required this.isCompleted,
  });

  factory TodoModel.fromEntity({
    required TodoEntity entity,
  }) =>
      TodoModel(
        todoId: entity.todoId,
        name: entity.name,
        isCompleted: entity.isCompleted,
      );

  @override
  List<Object?> get props => <Object?>[
        todoId,
        name,
        isCompleted,
      ];
}
