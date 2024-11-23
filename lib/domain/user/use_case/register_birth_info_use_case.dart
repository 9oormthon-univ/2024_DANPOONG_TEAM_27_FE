import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/user/request_body/register_birth_info_request_body.dart';
import '../../../data/user/user_repository.dart';
import '../../../ui/onboarding/onboarding_state.dart';

final AutoDisposeProvider<RegisterBirthInfoUseCase>
    registerBirthInfoUseCaseProvider =
    Provider.autoDispose<RegisterBirthInfoUseCase>(
  (AutoDisposeRef<RegisterBirthInfoUseCase> ref) => RegisterBirthInfoUseCase(
    userRepository: ref.read(userRepositoryProvider),
  ),
);

class RegisterBirthInfoUseCase {
  final UserRepository _userRepository;

  RegisterBirthInfoUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<UseCaseResult<void>> call({
    required GenderType gender,
    required BirthType solarOrLunar,
    required String year,
    required String month,
    required String day,
    required String hour,
    required String minute,
    required bool isAm,
    required bool unknownTime,
  }) async {
    final int requestHour = unknownTime
        ? 0
        : isAm
            ? int.parse(hour)
            : int.parse(hour) + 12;
    final int requestMinute = unknownTime ? 0 : int.parse(minute);
    final String requestGender = gender == GenderType.male ? 'male' : 'female';
    final String requestSolarOrLunar =
        solarOrLunar == BirthType.solar ? 'solar' : 'lunar';
    final RepositoryResult<void> repositoryResult =
        await _userRepository.registerBirthInfo(
      body: RegisterBirthInfoRequestBody(
        gender: requestGender,
        solarOrLunar: requestSolarOrLunar,
        year: int.parse(year),
        month: int.parse(month),
        day: int.parse(day),
        hour: requestHour,
        minute: requestMinute,
        unknownTime: unknownTime,
      ),
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<void>() =>
        const SuccessUseCaseResult<void>(data: null),
      FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
