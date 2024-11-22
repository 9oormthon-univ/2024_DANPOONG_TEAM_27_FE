import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/user/entity/login_info_entity.dart';
import '../../../data/user/user_repository.dart';
import '../model/login_info_model.dart';

final AutoDisposeProvider<GetLoginInfoUseCase> getLoginInfoUseCaseProvider =
    Provider.autoDispose<GetLoginInfoUseCase>(
  (AutoDisposeRef<GetLoginInfoUseCase> ref) => GetLoginInfoUseCase(
    userRepository: ref.read(userRepositoryProvider),
  ),
);

class GetLoginInfoUseCase {
  final UserRepository _userRepository;
  GetLoginInfoUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<UseCaseResult<LoginInfoModel>> call({
    required int goalId,
  }) async {
    final RepositoryResult<LoginInfoEntity> repositoryResult =
        await _userRepository.getUserLoginInfo();

    return switch (repositoryResult) {
      SuccessRepositoryResult<LoginInfoEntity>() =>
        SuccessUseCaseResult<LoginInfoModel>(
            data: LoginInfoModel.fromEntity(entity: repositoryResult.data)),
      FailureRepositoryResult<LoginInfoEntity>() =>
        FailureUseCaseResult<LoginInfoModel>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
