import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/data/entity_form.dart';
import '../../../core/common/data/list_entity_form.dart';
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
    final RepositoryResult<EntityForm<FortuneEntity>> repositoryResult =
        await _fortuneRepository.getFortune();

    return switch (repositoryResult) {
      SuccessRepositoryResult<EntityForm<FortuneEntity>>() =>
        SuccessUseCaseResult<FortuneModel>(
          data: FortuneModel.fromEntity(entity: repositoryResult.data.data),
        ),
      FailureRepositoryResult<EntityForm<FortuneEntity>>() =>
        FailureUseCaseResult<FortuneModel>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
