import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/loading_status.dart';
import 'onboarding_state.dart';

final AutoDisposeStateNotifierProvider<OnboardingViewModel, OnboardingState>
    onboardingViewModelProvider =
    StateNotifierProvider.autoDispose<OnboardingViewModel, OnboardingState>(
  (StateNotifierProviderRef<OnboardingViewModel, OnboardingState> ref) =>
      OnboardingViewModel(),
);

class OnboardingViewModel extends StateNotifier<OnboardingState> {
  OnboardingViewModel() : super(OnboardingState.init());

  void getUserName() {
    state = state.copyWith(getUserNameLoading: LoadingStatus.loading);
    state = state.copyWith(userName: '하수정');
    state = state.copyWith(getUserNameLoading: LoadingStatus.success);
  }

  void getSuggestions() {
    state = state.copyWith(getSuggestionsLoading: LoadingStatus.loading);
    state = state.copyWith(suggestions: <GoalSuggestionModel>[
      const GoalSuggestionModel(
        suggestedGoal: '긍정적인 사람 되어보기',
        suggestedDuration: '30일',
      ),
      const GoalSuggestionModel(
        suggestedGoal: '긍정적인 사람 되어보기',
        suggestedDuration: '30일',
      ),
      const GoalSuggestionModel(
        suggestedGoal: '긍정적인 사람 되어보기',
        suggestedDuration: '20일',
      ),
    ]);
    state = state.copyWith(getSuggestionsLoading: LoadingStatus.success);
  }

  void onTapSuggestion({
    required int index,
  }) {
    // 같은 것 선택 -> 취소 & text field 활성화
    if (index == state.selectedSuggestion) {
      state = state.copyWith(
        selectedSuggestion: -1,
        goal:
            state.goalInputFieldText.isNotEmpty ? state.goalInputFieldText : '',
      );
      debugPrint('현재 목표: ${state.goal}');
    }
    // 새로운 것 선택 -> 선택 & text field 비활성화
    else {
      state = state.copyWith(
        selectedSuggestion: index,
        goal: state.suggestions[index].suggestedGoal,
      );
      debugPrint('현재 목표: ${state.goal}');
    }
  }

  void onChangedGoalTextField({
    required String text,
  }) {
    state = state.copyWith(
      goalInputFieldText: text,
      goal: text,
    );
    debugPrint('현재 목표: ${state.goal}');
  }

  void onTapNextButtonInGoal() {}

  bool get enableGoalInputField => state.selectedSuggestion == -1;

  bool get activateNextButtonInGoal =>
      state.selectedSuggestion != -1 || state.goalInputFieldText.isNotEmpty;
}
