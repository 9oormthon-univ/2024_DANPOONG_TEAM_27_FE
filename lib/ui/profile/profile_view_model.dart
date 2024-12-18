import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luckit/ui/profile/widgets/profile_character_box_widget.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/goal/model/complete_goal_characters_model.dart';
import '../../domain/goal/model/complete_goal_model.dart';
import '../../domain/goal/use_case/get_characters_by_goal_use_case.dart';
import '../../domain/goal/use_case/get_complete_goal_list_use_case.dart';
import '../../domain/todo/model/graph_data_model.dart';
import '../../domain/todo/use_case/get_graph_data_use_case.dart';
import '../../domain/user/use_case/get_birth_info_use_case.dart';
import '../../domain/user/use_case/get_login_info_use_case.dart';
import '../../domain/user/use_case/register_birth_info_use_case.dart';
import '../onboarding/onboarding_state.dart';
import '../onboarding/utils/validation.dart';
import 'data/graph_data.dart';
import 'data/profile_data.dart';
import 'profile_state.dart';

final AutoDisposeStateNotifierProvider<ProfileViewModel, ProfileState>
profileViewModelProvider = StateNotifierProvider.autoDispose(
      (AutoDisposeRef<ProfileState> ref) =>
      ProfileViewModel(
        getBirthInfoUseCase: ref.read(getBirthInfoUseCaseProvider),
        getLoginInfoUseCase: ref.read(getLoginInfoUseCaseProvider),
        getCompleteGoalListUseCase: ref.read(
            getCompleteGoalListUseCaseProvider),
        registerBirthInfoUseCase: ref.read(registerBirthInfoUseCaseProvider),
        getGraphDataUseCase: ref.read(getGraphDataUseCaseProvider),
        getCharactersByGoalUseCase: ref.read(
            getCharactersByGoalUseCaseProvider),
      ),
);

class ProfileViewModel extends StateNotifier<ProfileState> {
  final GetBirthInfoUseCase _getBirthInfoUseCase;
  final GetLoginInfoUseCase _getLoginInfoUseCase;
  final GetCompleteGoalListUseCase _getCompleteGoalListUseCase;
  final RegisterBirthInfoUseCase _registerBirthInfoUseCase;
  final GetGraphDataUseCase _getGraphDataUseCase;
  final CharactersByGoalUseCaseProvider _getCharactersByGoalUseCase;

  ProfileViewModel({
    required GetBirthInfoUseCase getBirthInfoUseCase,
    required GetLoginInfoUseCase getLoginInfoUseCase,
    required GetCompleteGoalListUseCase getCompleteGoalListUseCase,
    required RegisterBirthInfoUseCase registerBirthInfoUseCase,
    required GetGraphDataUseCase getGraphDataUseCase,
    required CharactersByGoalUseCaseProvider getCharactersByGoalUseCase,
  })
      : _getBirthInfoUseCase = getBirthInfoUseCase,
        _getLoginInfoUseCase = getLoginInfoUseCase,
        _getCompleteGoalListUseCase = getCompleteGoalListUseCase,
        _registerBirthInfoUseCase = registerBirthInfoUseCase,
        _getGraphDataUseCase = getGraphDataUseCase,
        _getCharactersByGoalUseCase = getCharactersByGoalUseCase,
        super(ProfileState.init());

  Future<void> initProfileView() async {
    state = state.copyWith(
      loadingCharacters: LoadingStatus.loading,
      loadingGoalList: LoadingStatus.loading,
      loadingGraph: LoadingStatus.loading,
      loadingRegister: LoadingStatus.loading,
      loadingProfile: LoadingStatus.loading,
    );
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(
      loadingCharacters: LoadingStatus.success,
      loadingGoalList: LoadingStatus.success,
      loadingGraph: LoadingStatus.success,
      loadingRegister: LoadingStatus.success,
      loadingProfile: LoadingStatus.success,
      spotsList: graphData,
      currentGraphIndex: 0,
      completeGoal: [
        CompleteGoalModel(goalId: 1,
          name: '운동하기',
          countSuccessTodo: 12,
          characterWidgetList: datadaa,
          opened: false,
          startDay: 1,
          startYear: 2023,
          startMonth: 1,
          endYear: 2024,
          endMonth: 12,
          endDay: 31,)
      ],
    );
  }

  Future<void> getCompleteGoalList() async {
    state = state.copyWith(loadingGoalList: LoadingStatus.loading);
    // await
    final UseCaseResult<List<CompleteGoalModel>> result =
    await _getCompleteGoalListUseCase();

    switch (result) {
      case SuccessUseCaseResult<List<CompleteGoalModel>>():
        state = state.copyWith(
          completeGoal: result.data,
          loadingGoalList: LoadingStatus.success,
        );
      case FailureUseCaseResult<List<CompleteGoalModel>>():
        state = state.copyWith(loadingGraph: LoadingStatus.error);
    }
  }

  void getCurrentDate() {
    final DateTime curDateTime = DateTime.now();
    state = state.copyWith(
      currentYear: curDateTime.year,
      currentMonth: curDateTime.month,
    );
  }

  Future<void> toggleGoalArchiving({required int tapIndex}) async {
    final CompleteGoalModel goal = state.completeGoal[tapIndex];
    // toggle opened
    final List<CompleteGoalModel> updatedCompleteGoals =
    List<CompleteGoalModel>.from(state.completeGoal);
    updatedCompleteGoals[tapIndex] = updatedCompleteGoals[tapIndex].copyWith(
      opened: !state.completeGoal[tapIndex].opened,
    );
    state = state.copyWith(
      completeGoal: updatedCompleteGoals,
    );

    // 캐릭터가 비어있으면 가져오기
    if (goal.characterWidgetList == null) {
      state = state.copyWith(loadingCharacters: LoadingStatus.loading);
      final UseCaseResult<CompleteGoalCharactersModel> result =
      await _getCharactersByGoalUseCase(goalId: goal.goalId);
      switch (result) {
        case SuccessUseCaseResult():
          final List<CompleteGoalModel> updatedCompleteGoals =
          await List<CompleteGoalModel>.from(state.completeGoal);
          updatedCompleteGoals[tapIndex] =
              updatedCompleteGoals[tapIndex].copyWith(
                characterWidgetList: result.data,
                endDay: result.data.endDay,
                endMonth: result.data.endMonth,
                endYear: result.data.endYear,
                startDay: result.data.startDay,
                startMonth: result.data.startMonth,
                startYear: result.data.startYear,
              );
          state = state.copyWith(
            completeGoal: updatedCompleteGoals,
            loadingCharacters: LoadingStatus.success,
          );
        case FailureUseCaseResult():
          state = state.copyWith(loadingCharacters: LoadingStatus.error);
      }
    }
  }

  void getProfile() {
    state = state.copyWith(loadingProfile: LoadingStatus.loading);

    try {
      // await _getBirthInfoUseCase();
      // await _getLoginInfoUseCase();
      state = state.copyWith(
        loadingProfile: LoadingStatus.success,
        name: '마재훈',
        gender: GenderType.male,
        solarOrLunar: BirthType.solar,
        year: 2000.toString(),
        month: 3.toString(),
        day: 7.toString(),
        isAm: true,
        unknownTime: true,
      );
    } on DioException {
      state = state.copyWith(loadingProfile: LoadingStatus.error);
    }
  }

  void toggleProfileButtons({required bool isCurrentOpen}) {
    state = state.copyWith(isProfileButtonsOpen: !isCurrentOpen);
  }

  Future<void> getSpotList() async {
    state = state.copyWith(loadingGraph: LoadingStatus.loading);

    // 쿼리 파라미터 생성
    int queryMonth = state.currentMonth - state.spotsList.length;
    int queryYear = state.currentYear;
    while (queryMonth < 1) {
      queryMonth += 12;
      queryYear -= 1;
    }

    // 요청
    state = state.copyWith(queryMonth: queryMonth, queryYear: queryYear);
    final UseCaseResult<GraphDataModel> result = await _getGraphDataUseCase(
      month: queryMonth,
      year: queryYear,
    );
    // print('요청할 날: ${queryYear}년 ${queryMonth}월');
    switch (result) {
      case SuccessUseCaseResult<GraphDataModel>():
        state = state.copyWith(
          spotsList: <GraphDataModel>[
            result.data,
            ...state.spotsList,
          ],
          loadingGraph: LoadingStatus.success,
        );
    // print('현재 리스트 상태: ${state.spotsList}');
      case FailureUseCaseResult<GraphDataModel>():
        state = state.copyWith(loadingGraph: LoadingStatus.error);
    }
  }

  void onTapLeftArrow() {
    if (state.currentGraphIndex > 0) {
      state = state.copyWith(currentGraphIndex: state.currentGraphIndex - 1);
    }
    // 이전달 데이터 불러와야 함
    // getSpotList();
    // print('새로운 데이터 불러오기 성공');
    // state = state.copyWith(currentGraphIndex: 0);
  }

  void onTapRightArrow() {
    if (state.currentGraphIndex < state.spotsList.length - 1) {
      state = state.copyWith(currentGraphIndex: state.currentGraphIndex + 1);
    }
  }

  void onTapGenderButton({required String label}) {
    if (label == '남성') {
      state = state.copyWith(gender: GenderType.male);
    } else if (label == '여성') {
      state = state.copyWith(gender: GenderType.female);
    }
  }

  void onTapSolarOrLunarButton({required String label}) {
    if (label == '양력') {
      state = state.copyWith(solarOrLunar: BirthType.solar);
    } else if (label == '음력') {
      state = state.copyWith(solarOrLunar: BirthType.lunar);
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

  Future<void> onTapRegisterButton() async {
    state = state.copyWith(loadingRegister: LoadingStatus.loading);
    final UseCaseResult<void> result = await _registerBirthInfoUseCase(
      isAm: state.isAm,
      unknownTime: state.unknownTime,
      solarOrLunar: state.solarOrLunar,
      year: state.year,
      gender: state.gender,
      day: state.day,
      month: state.month,
      minute: state.minute,
      hour: state.hour,
    );
    switch (result) {
      case SuccessUseCaseResult<void>():
        if (mounted) {
          state = state.copyWith(loadingRegister: LoadingStatus.success);
        }
      case FailureUseCaseResult<void>():
        if (mounted) {
          state = state.copyWith(loadingRegister: LoadingStatus.error);
        }
    }
  }

  String? get yearErrorText => birthYearValidation(value: state.year);

  String? get monthErrorText => monthValidation(value: state.month);

  String? get dayErrorText =>
      startDayValidation(
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
