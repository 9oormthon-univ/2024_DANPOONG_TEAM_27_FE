import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/auth/auth_repository.dart';
import '../../../data/auth/entity/auth_token_entity.dart';
import '../model/auth_token_model.dart';

final AutoDisposeProvider<GetAuthUseCase> getAuthUseCaseProvider =
    Provider.autoDispose<GetAuthUseCase>(
  (AutoDisposeRef<GetAuthUseCase> ref) => GetAuthUseCase(
    authRepository: ref.read(authRepositoryProvider),
  ),
);

class GetAuthUseCase {
  final AuthRepository _authRepository;
  GetAuthUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Future<UseCaseResult<AuthTokenModel>> call({
    required String code,
  }) async {
    final RepositoryResult<AuthTokenEntity> repositoryResult =
        await _authRepository.kakaoCallback(code: code);
    return switch (repositoryResult) {
      SuccessRepositoryResult<AuthTokenEntity>() =>
        SuccessUseCaseResult<AuthTokenModel>(
          data: AuthTokenModel.fromEntity(
            entity: repositoryResult.data,
          ),
        ),
      FailureRepositoryResult<AuthTokenEntity>() =>
        FailureUseCaseResult<AuthTokenModel>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
