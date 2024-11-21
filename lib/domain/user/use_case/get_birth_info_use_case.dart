import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/user/entity/birth_info_entity.dart';
import '../../../data/user/user_repository.dart';
import '../model/birth_info_model.dart';

final AutoDisposeProvider<GetBirthInfoUseCase> getBirthInfoUseCaseProvider =
    Provider.autoDispose<GetBirthInfoUseCase>(
  (AutoDisposeRef<GetBirthInfoUseCase> ref) => GetBirthInfoUseCase(
    userRepository: ref.read(userRepositoryProvider),
  ),
);

class GetBirthInfoUseCase {
  final UserRepository _userRepository;
  GetBirthInfoUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<UseCaseResult<BirthInfoModel>> call({
    required int goalId,
  }) async {
    final RepositoryResult<BirthInfoEntity> repositoryResult =
        await _userRepository.getUserBirthInfo();

    return switch (repositoryResult) {
      SuccessRepositoryResult<BirthInfoEntity>() =>
        SuccessUseCaseResult<BirthInfoModel>(
          data: BirthInfoModel.fromEntity(
            entity: repositoryResult.data,
          ),
        ),
      FailureRepositoryResult<BirthInfoEntity>() =>
        FailureUseCaseResult<BirthInfoModel>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
