import 'package:equatable/equatable.dart';

import '../../../data/goal/entity/complete_goal_entity.dart';
import 'complete_goal_characters_model.dart';

class CompleteGoalModel extends Equatable {
  final int goalId;
  final String name;
  final int countSuccessTodo;
  final CompleteGoalCharactersModel? characterWidgetList;
  final bool opened;
  final int? startYear;
  final int? startMonth;
  final int? startDay;
  final int? endYear;
  final int? endMonth;
  final int? endDay;

  const CompleteGoalModel({
    required this.goalId,
    required this.name,
    required this.countSuccessTodo,
    required this.characterWidgetList,
    required this.opened,
    required this.startDay,
    required this.startYear,
    required this.startMonth,
    required this.endYear,
    required this.endMonth,
    required this.endDay,
  });

  CompleteGoalModel copyWith({
    int? goalId,
    String? name,
    int? countSuccessTodo,
    CompleteGoalCharactersModel? characterWidgetList,
    bool? opened,
    int? startDay,
    int? startYear,
    int? startMonth,
    int? endYear,
    int? endMonth,
    int? endDay,
  }) =>
      CompleteGoalModel(
        goalId: goalId ?? this.goalId,
        name: name ?? this.name,
        countSuccessTodo: countSuccessTodo ?? this.countSuccessTodo,
        characterWidgetList: characterWidgetList ?? this.characterWidgetList,
        opened: opened ?? this.opened,
        startYear: startYear ?? this.startYear,
        endDay: endDay ?? this.endDay,
        endMonth: endMonth ?? this.endMonth,
        endYear: endYear ?? this.endYear,
        startDay: startDay ?? this.startDay,
        startMonth: startMonth ?? this.startMonth,
      );

  @override
  List<Object?> get props => <Object?>[
        goalId,
        name,
        countSuccessTodo,
        opened,
      ];
}
