import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/goal/goal_repository.dart';

final AutoDisposeProvider<CreateGoalUseCase> createGoalUseCaseProvider =
    Provider.autoDispose<CreateGoalUseCase>(
  (AutoDisposeRef<CreateGoalUseCase> ref) => CreateGoalUseCase(
    goalRepository: ref.read(goalRepositoryProvider),
  ),
);

class CreateGoalUseCase {
  final GoalRepository _goalRepository;
  CreateGoalUseCase({
    required GoalRepository goalRepository,
  }) : _goalRepository = goalRepository;

  Future<UseCaseResult<void>> call({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final RepositoryResult<void> repositoryResult =
        await _goalRepository.createGoal(
      name: name,
      startDate: startDate,
      endDate: endDate,
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
