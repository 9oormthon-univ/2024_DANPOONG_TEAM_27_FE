import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/goal/use_case/create_goal_use_case.dart';
import '../../domain/onboarding/model/suggestion_goal_model.dart';
import '../../domain/onboarding/use_case/get_suggestion_goal_list_use_case.dart';
import 'editing_state.dart';

final AutoDisposeStateNotifierProvider<EditingViewModel, EditingState>
    editingViewModelProvider =
    StateNotifierProvider.autoDispose<EditingViewModel, EditingState>(
  (StateNotifierProviderRef<EditingViewModel, EditingState> ref) =>
      EditingViewModel(
    getSuggestionGoalListUseCase:
        ref.read(getSuggestionGoalListUseCaseProvider),
    createGoalUseCase: ref.read(createGoalUseCaseProvider),
  ),
);

class EditingViewModel extends StateNotifier<EditingState> {
  final GetSuggestionGoalListUseCase _getSuggestionGoalListUseCase;
  final CreateGoalUseCase _createGoalUseCase;

  EditingViewModel({
    required GetSuggestionGoalListUseCase getSuggestionGoalListUseCase,
    required CreateGoalUseCase createGoalUseCase,
  })  : _getSuggestionGoalListUseCase = getSuggestionGoalListUseCase,
        _createGoalUseCase = createGoalUseCase,
        super(EditingState.init());

  void getUserName() {
    state = state.copyWith(getUserNameLoading: LoadingStatus.loading);
    state = state.copyWith(userName: '미르미');
    state = state.copyWith(getUserNameLoading: LoadingStatus.success);
  }

  Future<void> getSuggestions() async {
    state = state.copyWith(getSuggestionsLoading: LoadingStatus.loading);
    final UseCaseResult<List<GoalModel>> result =
        await _getSuggestionGoalListUseCase();

    switch (result) {
      case SuccessUseCaseResult<List<GoalModel>>():
        state = state.copyWith(suggestions: result.data);
      case FailureUseCaseResult<List<GoalModel>>():
        state = state.copyWith(getSuggestionsLoading: LoadingStatus.error);
    }
    state = state.copyWith(getSuggestionsLoading: LoadingStatus.success);
  }

  Future<void> createGoal() async {
    state = state.copyWith(createGoalLoadingStatus: LoadingStatus.loading);
    final UseCaseResult<void> result = await _createGoalUseCase(
      name: state.goal,
      startDate: DateTime(
        int.parse(state.startYear),
        int.parse(state.startMonth),
        int.parse(state.startDay),
      ),
      endDate: DateTime(
        int.parse(state.endYear),
        int.parse(state.endMonth),
        int.parse(state.endDay),
      ),
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(createGoalLoadingStatus: LoadingStatus.success);
      case FailureUseCaseResult<void>():
        state = state.copyWith(createGoalLoadingStatus: LoadingStatus.error);
    }
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
        goal: state.suggestions[index].goals,
        suggestedDuration: state.suggestions[index].period,
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
      if (year < DateTime.now().year) {
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

  bool isValidDate(String year, String month, String day) {
    if (year.isEmpty || month.isEmpty || day.isEmpty) {
      return true;
    }

    try {
      final int y = int.parse(year);
      final int m = int.parse(month);
      final int d = int.parse(day);

      final DateTime date = DateTime(y, m, d);
      return date.year == y && date.month == m && date.day == d;
    } on Exception {
      return false;
    }
  }

  String? startDayValidation({
    required String day,
    required String month,
    required String year,
    bool isBirthday = false,
  }) {
    if (day.isEmpty || month.isEmpty || year.isEmpty) {
      return null;
    }

    try {
      int.parse(day);
    } on Exception {
      return '숫자만 입력해주세요';
    }

    final int intDay = int.parse(day);
    if (intDay < 1 || intDay > 31) {
      return '일을 정확히 입력해주세요';
    }

    if (!isValidDate(year, month, day)) {
      return '유효하지 않은 날짜입니다';
    }

    if (!isBirthday && year.isNotEmpty && month.isNotEmpty) {
      try {
        final DateTime inputDate = DateTime(
          int.parse(year),
          int.parse(month),
          int.parse(day),
        );
        final DateTime today = DateTime.now();
        if (inputDate.isBefore(DateTime(today.year, today.month, today.day))) {
          return '오늘보다 이전 날짜는 선택할 수 없습니다';
        }
      } on Exception {
        //
      }
    }

    return null;
  }

  String? endDayValidation({
    required String endDay,
    required String endMonth,
    required String endYear,
    required String startDay,
    required String startMonth,
    required String startYear,
  }) {
    if (endDay.isEmpty) {
      return null;
    }

    try {
      int.parse(endDay);
    } on Exception {
      return '숫자만 입력해주세요';
    }

    final int intDay = int.parse(endDay);
    if (intDay < 1 || intDay > 31) {
      return '일을 정확히 입력해주세요';
    }

    if (!isValidDate(endYear, endMonth, endDay)) {
      return '유효하지 않은 날짜입니다';
    }

    if (startYear.isNotEmpty &&
        startMonth.isNotEmpty &&
        startDay.isNotEmpty &&
        endYear.isNotEmpty &&
        endMonth.isNotEmpty) {
      try {
        final DateTime startDate = DateTime(
          int.parse(startYear),
          int.parse(startMonth),
          int.parse(startDay),
        );
        final DateTime endDate = DateTime(
          int.parse(endYear),
          int.parse(endMonth),
          int.parse(endDay),
        );

        if (endDate.isBefore(startDate)) {
          return '종료일이 시작일보다 빠를 수 없습니다';
        }

        final int difference = endDate.difference(startDate).inDays;
        if (difference < 14) {
          return '기간은 최소 14일 이상이어야 합니다';
        }
      } on Exception {
        //
      }
    }

    return null;
  }

  bool get enableGoalInputField => state.selectedSuggestion == -1;

  bool get activateNextButtonInGoal =>
      state.selectedSuggestion != -1 || state.goalInputFieldText.isNotEmpty;

  String? get startYearErrorText => startYearValidation(value: state.startYear);

  String? get startMonthErrorText => monthValidation(value: state.startMonth);

  String? get startDayErrorText => startDayValidation(
        day: state.startDay,
        month: state.startMonth,
        year: state.startYear,
      );

  String? get endYearErrorText => endYearValidation(value: state.endYear);

  String? get endMonthErrorText => monthValidation(value: state.endMonth);

  String? get endDayErrorText => endDayValidation(
        endDay: state.endDay,
        endMonth: state.endMonth,
        endYear: state.endYear,
        startDay: state.startDay,
        startMonth: state.startMonth,
        startYear: state.startYear,
      );

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

  String? get birthDayErrorText => startDayValidation(
        day: state.birthDay,
        month: state.birthMonth,
        year: state.birthYear,
        isBirthday: true,
      );

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
