import 'package:equatable/equatable.dart';

import '../../../data/goal/entity/goal_entity.dart';

class GoalModel extends Equatable {
  final int goalId;
  final String name;
  final bool isCompleted;
  final DateTime startDate;
  final DateTime endDate;

  const GoalModel({
    required this.goalId,
    required this.name,
    required this.isCompleted,
    required this.startDate,
    required this.endDate,
  });

  factory GoalModel.fromEntity({
    required GoalEntity entity,
  }) =>
      GoalModel(
          goalId: entity.goalId,
          name: entity.name,
          isCompleted: entity.isCompleted,
          startDate: DateTime(
            entity.startDateYear,
            entity.startDateMonth,
            entity.startDateDay,
          ),
          endDate: DateTime(
            entity.endDateYear,
            entity.endDateMonth,
            entity.endDateDay,
          ));

  @override
  List<Object?> get props => <Object?>[
        goalId,
        name,
        isCompleted,
        startDate,
        endDate,
      ];
}