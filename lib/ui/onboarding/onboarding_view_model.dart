import 'package:flutter/material.dart';
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
        suggestedDuration: '',
      );
      debugPrint('현재 목표: ${state.goal}');
    }
    // 새로운 것 선택 -> 선택 & text field 비활성화
    else {
      state = state.copyWith(
        selectedSuggestion: index,
        goal: state.suggestions[index].suggestedGoal,
        suggestedDuration: state.suggestions[index].suggestedDuration,
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

  // -----birth-----
  void onPressedGender({required Gender gender}) {
    state = state.copyWith(gender: gender);
  }

  void onPressedBirthType({required BirthType birthType}) {
    state = state.copyWith(birthType: birthType);
  }

  void onPressedDayPeriod({required DayPeriod dayPeriod}) {
    state = state.copyWith(dayPeriod: dayPeriod);
  }

  void onChangedBirthYear({required String value}) {
    state = state.copyWith(birthYear: value);
  }

  void onChangedBirthMonth({required String value}) {
    state = state.copyWith(birthMonth: value);
  }

  void onChangedBirthDay({required String value}) {
    state = state.copyWith(birthDay: value);
  }

  void onChangedBirthHour({required String value}) {
    state = state.copyWith(birthHour: value);
  }

  void onChangedBirthMinute({required String value}) {
    state = state.copyWith(birthMinute: value);
  }

  void onPressedDontKnow() {
    state = state.copyWith(dontKnow: !state.dontKnow);
  }

  void onPressedAgree() {
    state = state.copyWith(agree: !state.agree);
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

  String? birthYearValidation({required String value}) {
    if (value.isEmpty) {
      return null;
    }
    try {
      final int year = int.parse(value);
      if (year >= DateTime.now().year) {
        return '태어난 연도를 정확히 입력해주세요';
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

  String? hourValidation({required String value}) {
    if (value.isEmpty) {
      return null;
    }
    try {
      final int hour = int.parse(value);
      if (hour < 1 || hour > 12) {
        return '시간을 정확히 입력해주세요';
      }
      return null;
    } on Exception {
      return '숫자만 입력해주세요';
    }
  }

  String? minuteValidation({required String value}) {
    if (value.isEmpty) {
      return null;
    }
    try {
      final int minute = int.parse(value);
      if (minute < 0 || minute > 59) {
        return '분을 정확히 입력해주세요';
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

  String? get birthYearErrorText => birthYearValidation(value: state.birthYear);

  String? get birthMonthErrorText => monthValidation(value: state.birthMonth);

  String? get birthDayErrorText => dayValidation(value: state.birthDay);

  String? get birthHourErrorText => hourValidation(value: state.birthHour);

  String? get birthMinuteErrorText =>
      minuteValidation(value: state.birthMinute);

  bool get activateNextButtonInBirth =>
      state.agree &&
      state.birthYear.isNotEmpty &&
      state.birthMonth.isNotEmpty &&
      state.birthDay.isNotEmpty &&
      birthYearErrorText == null &&
      birthMonthErrorText == null &&
      birthDayErrorText == null &&
      (state.dontKnow ||
          (state.birthHour.isNotEmpty &&
              state.birthMinute.isNotEmpty &&
              birthHourErrorText == null &&
              birthHourErrorText == null));
}
