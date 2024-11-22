import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/fortune/entity/fortune_entity.dart';
import '../../../data/fortune/fortune_repository.dart';
import '../model/fortune_model.dart';

final AutoDisposeProvider<GetFortuneUseCase> getFortuneUseCaseProvider =
    Provider.autoDispose<GetFortuneUseCase>(
  (AutoDisposeRef<GetFortuneUseCase> ref) => GetFortuneUseCase(
    fortuneRepository: ref.read(fortuneRepositoryProvider),
  ),
);

class GetFortuneUseCase {
  final FortuneRepository _fortuneRepository;
  GetFortuneUseCase({
    required FortuneRepository fortuneRepository,
  }) : _fortuneRepository = fortuneRepository;

  Future<UseCaseResult<FortuneModel>> call() async {
    final RepositoryResult<FortuneEntity> repositoryResult =
        await _fortuneRepository.getFortune();

    return switch (repositoryResult) {
      SuccessRepositoryResult<FortuneEntity>() =>
        SuccessUseCaseResult<FortuneModel>(
          data: FortuneModel.fromEntity(entity: repositoryResult.data),
        ),
      FailureRepositoryResult<FortuneEntity>() =>
        FailureUseCaseResult<FortuneModel>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
