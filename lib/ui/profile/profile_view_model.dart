import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/loading_status.dart';
import '../../domain/goal/use_case/get_complete_goal_list_use_case.dart';
import '../../domain/user/use_case/get_birth_info_use_case.dart';
import '../../domain/user/use_case/get_login_info_use_case.dart';
import '../onboarding/utils/validation.dart';
import 'data/graph_data.dart';
import 'profile_state.dart';

final AutoDisposeStateNotifierProvider<ProfileViewModel, ProfileState>
    profileViewModelProvider = StateNotifierProvider.autoDispose(
  (AutoDisposeRef<ProfileState> ref) => ProfileViewModel(
    getBirthInfoUseCase: ref.read(getBirthInfoUseCaseProvider),
    getLoginInfoUseCase: ref.read(getLoginInfoUseCaseProvider),
    getCompleteGoalListUseCase: ref.read(getCompleteGoalListUseCaseProvider),
  ),
);

class ProfileViewModel extends StateNotifier<ProfileState> {
  final GetBirthInfoUseCase _getBirthInfoUseCase;
  final GetLoginInfoUseCase _getLoginInfoUseCase;
  final GetCompleteGoalListUseCase _getCompleteGoalListUseCase;

  ProfileViewModel({
    required GetBirthInfoUseCase getBirthInfoUseCase,
    required GetLoginInfoUseCase getLoginInfoUseCase,
    required GetCompleteGoalListUseCase getCompleteGoalListUseCase,
  })  : _getBirthInfoUseCase = getBirthInfoUseCase,
        _getLoginInfoUseCase = getLoginInfoUseCase,
        _getCompleteGoalListUseCase = getCompleteGoalListUseCase,
        super(ProfileState.init());

  void toggleGoalArchiving() {
    state = state.copyWith(opened: !state.opened);
  }

  void getProfile() {
    state = state.copyWith(loadingProfile: LoadingStatus.loading);

    try {
      // await _getBirthInfoUseCase();
      // await _getLoginInfoUseCase();
      state = state.copyWith(
        loadingProfile: LoadingStatus.success,
        name: '미르미',
        gender: '여성',
        solarOrLunar: '양력',
        year: 2003.toString(),
        month: 3.toString(),
        day: 7.toString(),
        isAm: true,
        unknownTime: true,
      );
    } on DioException {
      state = state.copyWith(loadingProfile: LoadingStatus.error);
    }
  }

  void getCompleteGoalList() {
    // await _getCompleteGoalListUseCase();
  }

  void toggleProfileButtons({required bool isCurrentOpen}) {
    state = state.copyWith(isProfileButtonsOpen: !isCurrentOpen);
  }

  void getSpotList() {
    state = state.copyWith(loadingGraph: LoadingStatus.loading);
    try {
      final List<List<FlSpot>> spotsList = graphData;
      state = state.copyWith(
        loadingGraph: LoadingStatus.success,
        spotsList: spotsList,
      );
    } on DioException {
      state = state.copyWith(loadingGraph: LoadingStatus.error);
    }
  }

  void onTapLeftArrow() {
    if (state.currentGraphIndex > 0) {
      state = state.copyWith(currentGraphIndex: state.currentGraphIndex - 1);
    }
  }

  void onTapRightArrow() {
    if (state.currentGraphIndex < state.spotsList.length - 1) {
      state = state.copyWith(currentGraphIndex: state.currentGraphIndex + 1);
    }
  }

  void onTapGenderButton({required String label}) {
    if (label == '남성') {
      state = state.copyWith(gender: '남성');
    } else if (label == '여성') {
      state = state.copyWith(gender: '여성');
    }
  }

  void onTapSolarOrLunarButton({required String label}) {
    if (label == '양력') {
      state = state.copyWith(solarOrLunar: '양력');
    } else if (label == '음력') {
      state = state.copyWith(solarOrLunar: '음력');
    }
  }

  void onChangedYear({required String value}) {
    state = state.copyWith(year: value);
  }

  void onChangedMonth({required String value}) {
    state = state.copyWith(month: value);
  }

  void onChangedDay({required String value}) {
    state = state.copyWith(day: value);
  }

  void onChangedHour({required String value}) {
    state = state.copyWith(hour: value);
  }

  void onChangedMinute({required String value}) {
    state = state.copyWith(minute: value);
  }

  void toggleUnknown({required bool currentUnknown}) {
    state = state.copyWith(unknownTime: !currentUnknown);
  }

  void toggleAm({required bool current}) {
    state = state.copyWith(isAm: !current);
  }

  String? get yearErrorText => birthYearValidation(value: state.year);

  String? get monthErrorText => monthValidation(value: state.month);

  String? get dayErrorText => startDayValidation(
        day: state.day,
        month: state.month,
        year: state.year,
        isBirthday: true,
      );

  String? get hourErrorText => hourValidation(value: state.hour);

  String? get minuteErrorText => minuteValidation(value: state.minute);

  bool get activateEditButton =>
      state.year.isNotEmpty &&
      state.month.isNotEmpty &&
      state.day.isNotEmpty &&
      yearErrorText == null &&
      monthErrorText == null &&
      dayErrorText == null &&
      (state.unknownTime ||
          (state.hour.isNotEmpty &&
              state.minute.isNotEmpty &&
              hourErrorText == null &&
              minuteErrorText == null));
}
