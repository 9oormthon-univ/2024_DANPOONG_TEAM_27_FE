import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/goal/goal_repository.dart';

final AutoDisposeProvider<DeleteGoalUseCase> deleteGoalUseCaseProvider =
    Provider.autoDispose<DeleteGoalUseCase>(
  (AutoDisposeRef<DeleteGoalUseCase> ref) => DeleteGoalUseCase(
    goalRepository: ref.read(goalRepositoryProvider),
  ),
);

class DeleteGoalUseCase {
  final GoalRepository _goalRepository;
  DeleteGoalUseCase({
    required GoalRepository goalRepository,
  }) : _goalRepository = goalRepository;

  Future<UseCaseResult<void>> call({required int goalId}) async {
    final RepositoryResult<void> repositoryResult =
        await _goalRepository.deleteGoal(goalId: goalId);

    return switch (repositoryResult) {
      SuccessRepositoryResult<void>() => const SuccessUseCaseResult<void>(
          data: null,
        ),
      FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
