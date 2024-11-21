import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/goal/goal_repository.dart';

final AutoDisposeProvider<ToggleGoalCompleteUseCase>
    toggleGoalCompleteUseCaseProvider =
    Provider.autoDispose<ToggleGoalCompleteUseCase>(
  (AutoDisposeRef<ToggleGoalCompleteUseCase> ref) => ToggleGoalCompleteUseCase(
    goalRepository: ref.read(goalRepositoryProvider),
  ),
);

class ToggleGoalCompleteUseCase {
  final GoalRepository _goalRepository;
  ToggleGoalCompleteUseCase({
    required GoalRepository goalRepository,
  }) : _goalRepository = goalRepository;

  Future<UseCaseResult<void>> call({
    required int goalId,
  }) async {
    final RepositoryResult<void> repositoryResult =
        await _goalRepository.toggleGoalComplete(
      goalId: goalId,
    );

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
