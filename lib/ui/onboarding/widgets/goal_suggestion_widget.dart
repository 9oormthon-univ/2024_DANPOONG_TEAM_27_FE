import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/onboarding/model/suggestion_goal_model.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import 'check_icon_widget.dart';
import 'suggested_duration_widget.dart';

class GoalSuggestionWidget extends ConsumerWidget {
  final int index;
  final SuggestionGoalModel model;
  final VoidCallback onPressedCheck;

  const GoalSuggestionWidget({
    required this.index,
    required this.model,
    required this.onPressedCheck,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingState state = ref.watch(onboardingViewModelProvider);
    final bool isChecked = state.selectedSuggestion == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.only(
          left: 12.0, right: 12.0, top: 14.0, bottom: 8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        color: LuckitColors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 10.0,
            color: LuckitColors.shadow2.withOpacity(0.15),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.goals,
                style: LuckitTypos.suitSB16.copyWith(
                  color: state.goal.isEmpty || state.selectedSuggestion > -1
                      ? LuckitColors.main
                      : (isChecked ? LuckitColors.main : LuckitColors.gray40),
                ),
              ),
              const SizedBox(height: 8.0),
              SuggestedDurationWidget(
                isChecked: isChecked,
                duration: model.period,
              ),
            ],
          ),
          CheckIconWidget(
            isChecked: index == state.selectedSuggestion,
            onPressed: onPressedCheck,
          ),
        ],
      ),
    );
  }
}
