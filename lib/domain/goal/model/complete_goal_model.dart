import 'package:equatable/equatable.dart';

import '../../../data/goal/entity/complete_goal_entity.dart';

class CompleteGoalModel extends Equatable {
  final int goalId;
  final String name;
  final int countSuccessTodo;

  const CompleteGoalModel({
    required this.goalId,
    required this.name,
    required this.countSuccessTodo,
  });

  factory CompleteGoalModel.fromEntity({required CompleteGoalEntity entity}) =>
      CompleteGoalModel(
        name: entity.name,
        countSuccessTodo: entity.countSuccessTodo,
        goalId: entity.goalId,
      );

  @override
  List<Object?> get props => <Object?>[
        goalId,
        name,
        countSuccessTodo,
      ];
}
