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

  Future<UseCaseResult<String>> call({
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
    final int requestHour = isAm ? int.parse(hour) : int.parse(hour) + 12;
    final RepositoryResult<String> repositoryResult =
        await _userRepository.registerBirthInfo(
      body: RegisterBirthInfoRequestBody(
        gender: gender.toString(),
        solarOrLunar: solarOrLunar.toString(),
        year: int.parse(year),
        month: int.parse(month),
        day: int.parse(day),
        hour: requestHour,
        minute: int.parse(minute),
        unknownTime: unknownTime,
      ),
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<String>() =>
        SuccessUseCaseResult<String>(data: repositoryResult.data),
      FailureRepositoryResult<String>() => FailureUseCaseResult<String>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
