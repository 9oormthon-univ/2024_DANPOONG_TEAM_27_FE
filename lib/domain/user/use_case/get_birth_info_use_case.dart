import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/data/entity_form.dart';
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

  Future<UseCaseResult<BirthInfoModel>> call() async {
    final RepositoryResult<EntityForm<BirthInfoEntity>> repositoryResult =
        await _userRepository.getUserBirthInfo();

    return switch (repositoryResult) {
      SuccessRepositoryResult<EntityForm<BirthInfoEntity>>() =>
        SuccessUseCaseResult<BirthInfoModel>(
          data: BirthInfoModel.fromEntity(
            entity: repositoryResult.data.data,
          ),
        ),
      FailureRepositoryResult<EntityForm<BirthInfoEntity>>() =>
        FailureUseCaseResult<BirthInfoModel>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
