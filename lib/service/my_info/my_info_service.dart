import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/fortune/model/fortune_model.dart';
import '../../domain/fortune/use_case/get_fortune_use_case.dart';
import '../../domain/user/model/birth_info_model.dart';
import '../../domain/user/model/login_info_model.dart';
import '../../domain/user/use_case/get_birth_info_use_case.dart';
import '../../domain/user/use_case/get_login_info_use_case.dart';
import '../../ui/onboarding/onboarding_state.dart';
import 'my_info_state.dart';

final StateNotifierProvider<MyInfoService, MyInfoState> myInfoServiceProvider =
    StateNotifierProvider<MyInfoService, MyInfoState>(
  (Ref ref) => MyInfoService(
    getBirthInfoUseCase: ref.read(getBirthInfoUseCaseProvider),
    getFortuneUseCase: ref.read(getFortuneUseCaseProvider),
    getLoginInfoUseCase: ref.read(getLoginInfoUseCaseProvider),
    state: MyInfoState.init(),
  ),
);

class MyInfoService extends StateNotifier<MyInfoState> {
  MyInfoService({
    required GetBirthInfoUseCase getBirthInfoUseCase,
    required GetLoginInfoUseCase getLoginInfoUseCase,
    required GetFortuneUseCase getFortuneUseCase,
    required MyInfoState state,
  })  : _getBirthInfoUseCase = getBirthInfoUseCase,
        _getFortuneUseCase = getFortuneUseCase,
        _getLoginInfoUseCase = getLoginInfoUseCase,
        super(state);

  final GetBirthInfoUseCase _getBirthInfoUseCase;
  final GetLoginInfoUseCase _getLoginInfoUseCase;
  final GetFortuneUseCase _getFortuneUseCase;

  Future<void> getUserInfo() async {
    await getUserLoginInfo();
    await getUserBirthInfo();
    await getFortune();
  }
  Future<void> getUserLoginInfo() async {
    final UseCaseResult<LoginInfoModel> result = await _getLoginInfoUseCase();
    switch (result) {
      case SuccessUseCaseResult<LoginInfoModel>():
        state = state.copyWith(
          getUserLoginInfoLoadingStatus: LoadingStatus.success,
          userName: result.data.name,
        );
      case FailureUseCaseResult<LoginInfoModel>():
        state = state.copyWith(
          getUserLoginInfoLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> getUserBirthInfo() async {
    state =
        state.copyWith(getUserBirthInfoLoadingStatus: LoadingStatus.loading);
    final UseCaseResult<BirthInfoModel> result = await _getBirthInfoUseCase();

    switch (result) {
      case SuccessUseCaseResult<BirthInfoModel>():
        state = state.copyWith(
          gender: result.data.gender == 'female'
              ? GenderType.female
              : GenderType.male,
          solarOrLunar: result.data.solarOrLunar == 'solar'
              ? BirthType.solar
              : BirthType.lunar,
          year: result.data.year.toString(),
          month: result.data.month.toString(),
          day: result.data.day.toString(),
          hour: result.data.hour.toString(),
          minute: result.data.minute.toString(),
          unknownTime: result.data.unknownTime,
          getUserBirthInfoLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<BirthInfoModel>():
        state = state.copyWith(
          getUserBirthInfoLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> getFortune() async {
    state = state.copyWith(
      getUserFortuneInfoLoadingStatus: LoadingStatus.loading,
    );
    final UseCaseResult<FortuneModel> result = await _getFortuneUseCase();

    switch (result) {
      case SuccessUseCaseResult<FortuneModel>():
        state = state.copyWith(
          userFortune: result.data,
          getUserFortuneInfoLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<FortuneModel>():
        state = state.copyWith(
          getUserFortuneInfoLoadingStatus: LoadingStatus.error,
        );
    }
  }
}
