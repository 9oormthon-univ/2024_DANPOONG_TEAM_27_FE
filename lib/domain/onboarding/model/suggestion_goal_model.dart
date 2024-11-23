import 'package:equatable/equatable.dart';

import '../../../data/onboarding/entity/suggestion_goal_entity.dart';


class SuggestionGoalModel extends Equatable {
  final String goals;
  final String period;

  const SuggestionGoalModel({
    required this.goals,
    required this.period,
  });

  factory SuggestionGoalModel.fromEntity({
    required SuggestionGoalEntity entity,
  }) =>
      SuggestionGoalModel(
        goals: entity.goals,
        period: entity.period,
      );

  @override
  List<Object?> get props => <Object?>[
        goals,
        period,
      ];
}
