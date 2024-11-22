import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/loading_status.dart';
import '../../domain/user/use_case/get_birth_info_use_case.dart';
import '../../domain/user/use_case/get_login_info_use_case.dart';
import 'profile_state.dart';

final AutoDisposeStateNotifierProvider<ProfileViewModel, ProfileState>
profileViewModelProvider = StateNotifierProvider.autoDispose(
      (AutoDisposeRef<ProfileState> ref) =>
      ProfileViewModel(
        getBirthInfoUseCase: ref.read(getBirthInfoUseCaseProvider),
        getLoginInfoUseCase: ref.read(getLoginInfoUseCaseProvider),
      ),
);

class ProfileViewModel extends StateNotifier<ProfileState> {
  final GetBirthInfoUseCase _getBirthInfoUseCase;
  final GetLoginInfoUseCase _getLoginInfoUseCase;

  ProfileViewModel({
    required GetBirthInfoUseCase getBirthInfoUseCase,
    required GetLoginInfoUseCase getLoginInfoUseCase,
  })
      : _getBirthInfoUseCase = getBirthInfoUseCase,
        _getLoginInfoUseCase = getLoginInfoUseCase,
        super(const ProfileState.init());

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

  void toggleProfileButtons({required bool isCurrentOpen}) {
    state = state.copyWith(isProfileButtonsOpen: !isCurrentOpen);
  }
}
