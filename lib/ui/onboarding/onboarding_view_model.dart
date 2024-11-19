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
    state = state.copyWith(userName: '미르미');
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

  // -----duration-----
  void onChangedStartYear({required String value}) {
    state = state.copyWith(startYear: value);
  }

  void onChangedStartMonth({required String value}) {
    state = state.copyWith(startMonth: value);
  }

  void onChangedStartDay({required String value}) {
    state = state.copyWith(startDay: value);
  }

  void onChangedEndYear({required String value}) {
    state = state.copyWith(endYear: value);
  }

  void onChangedEndMonth({required String value}) {
    state = state.copyWith(endMonth: value);
  }

  void onChangedEndDay({required String value}) {
    state = state.copyWith(endDay: value);
  }

  // -----validation-----
  String? startYearValidation({required String value}) {
    if (value.isEmpty) {
      return null;
    }
    try {
      final int year = int.parse(value);
      if (year != DateTime.now().year) {
        return '연도를 정확히 입력해주세요';
      }
      return null;
    } on Exception {
      return '숫자만 입력해주세요';
    }
  }

  String? endYearValidation({required String value}) {
    if (value.isEmpty) {
      return null;
    }
    try {
      final int year = int.parse(value);
      if (year < DateTime.now().year) {
        return '연도를 정확히 입력해주세요';
      }
      return null;
    } on Exception {
      return '숫자만 입력해주세요';
    }
  }

  String? monthValidation({required String value}) {
    if (value.isEmpty) {
      return null;
    }
    try {
      final int month = int.parse(value);
      if (month < 1 || month > 12) {
        return '월을 정확히 입력해주세요';
      }
      return null;
    } on Exception {
      return '숫자만 입력해주세요';
    }
  }

  String? dayValidation({required String value}) {
    if (value.isEmpty) {
      return null;
    }
    try {
      final int day = int.parse(value);
      if (day < 1 || day > 31) {
        return '일을 정확히 입력해주세요';
      }
      return null;
    } on Exception {
      return '숫자만 입력해주세요';
    }
  }

  bool get enableGoalInputField => state.selectedSuggestion == -1;

  bool get activateNextButtonInGoal =>
      state.selectedSuggestion != -1 || state.goalInputFieldText.isNotEmpty;

  String? get startYearErrorText => startYearValidation(value: state.startYear);

  String? get startMonthErrorText => monthValidation(value: state.startMonth);

  String? get startDayErrorText => dayValidation(value: state.startDay);

  String? get endYearErrorText => endYearValidation(value: state.endYear);

  String? get endMonthErrorText => monthValidation(value: state.endMonth);

  String? get endDayErrorText => dayValidation(value: state.endDay);

  bool get activateNextButtonInDuration =>
      state.startYear.isNotEmpty &&
      state.startMonth.isNotEmpty &&
      state.startDay.isNotEmpty &&
      state.endYear.isNotEmpty &&
      state.endMonth.isNotEmpty &&
      state.endDay.isNotEmpty &&
      startYearErrorText == null &&
      startMonthErrorText == null &&
      startDayErrorText == null &&
      endYearErrorText == null &&
      endMonthErrorText == null &&
      endDayErrorText == null;
}
