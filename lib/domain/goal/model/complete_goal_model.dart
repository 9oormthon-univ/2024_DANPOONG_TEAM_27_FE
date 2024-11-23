import 'package:equatable/equatable.dart';

import '../../../data/goal/entity/complete_goal_entity.dart';
import 'complete_goal_characters_model.dart';

class CompleteGoalModel extends Equatable {
  final int goalId;
  final String name;
  final int countSuccessTodo;
  final CompleteGoalCharactersModel? characterWidgetList;
  final bool opened;

  const CompleteGoalModel({
    required this.goalId,
    required this.name,
    required this.countSuccessTodo,
    required this.characterWidgetList,
    required this.opened,
  });

  CompleteGoalModel copyWith({
    int? goalId,
    String? name,
    int? countSuccessTodo,
    CompleteGoalCharactersModel? characterWidgetList,
    bool? opened,
  }) => CompleteGoalModel(
      goalId: goalId ?? this.goalId,
      name: name ?? this.name,
      countSuccessTodo: countSuccessTodo ?? this.countSuccessTodo,
      characterWidgetList: characterWidgetList ?? this.characterWidgetList,
      opened: opened ?? this.opened,
    );

  @override
  List<Object?> get props => <Object?>[
        goalId,
        name,
        countSuccessTodo,
        opened,
      ];
}
