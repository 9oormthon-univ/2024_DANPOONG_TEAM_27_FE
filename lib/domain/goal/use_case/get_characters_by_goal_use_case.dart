import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/data/entity_form.dart';
import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/goal/entity/goal_detail_entity.dart';
import '../../../data/goal/goal_repository.dart';
import '../model/complete_goal_characters_model.dart';

final AutoDisposeProvider<CharactersByGoalUseCaseProvider>
    getCharactersByGoalUseCaseProvider =
    Provider.autoDispose<CharactersByGoalUseCaseProvider>(
  (AutoDisposeRef<CharactersByGoalUseCaseProvider> ref) =>
      CharactersByGoalUseCaseProvider(
    goalRepository: ref.read(goalRepositoryProvider),
  ),
);

class CharactersByGoalUseCaseProvider {
  final GoalRepository _goalRepository;

  CharactersByGoalUseCaseProvider({
    required GoalRepository goalRepository,
  }) : _goalRepository = goalRepository;

  Future<UseCaseResult<CompleteGoalCharactersModel>> call({
    required int goalId,
  }) async {
    final RepositoryResult<EntityForm<GoalDetailEntity>> repositoryResult =
        await _goalRepository.getGoalSummary(goalId: goalId);

    return switch (repositoryResult) {
      SuccessRepositoryResult<EntityForm<GoalDetailEntity>>() =>
        SuccessUseCaseResult<CompleteGoalCharactersModel>(
          data: CompleteGoalCharactersModel.fromEntity(
            entity: repositoryResult.data.data,
          ),
        ),
      FailureRepositoryResult<EntityForm<GoalDetailEntity>>() =>
        FailureUseCaseResult<CompleteGoalCharactersModel>(
          message: repositoryResult.messages?[0],
        ),
    };
  }
}
