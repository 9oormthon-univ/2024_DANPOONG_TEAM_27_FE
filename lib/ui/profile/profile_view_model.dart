import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/loading_status.dart';
import '../../domain/goal/use_case/get_complete_goal_list_use_case.dart';
import '../../domain/user/use_case/get_birth_info_use_case.dart';
import '../../domain/user/use_case/get_login_info_use_case.dart';
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
        year: 2003.toString(),
        month: 3.toString(),
        day: 7.toString(),
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
}
