import 'package:equatable/equatable.dart';

import '../../../data/onboarding/entity/suggestion_goal_entity.dart';



class GoalModel extends Equatable {
  final String goals;
  final String period;

  const GoalModel({
    required this.goals,
    required this.period,
  });

  factory GoalModel.fromEntity({
    required SuggestionGoalEntity entity,
  }) =>
      GoalModel(
        goals: entity.goals,
        period: entity.period,
      );

  @override
  List<Object?> get props => <Object?>[
        goals,
        period,
      ];
}
