import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/goal/entity/complete_goal_entity.dart';
import '../../../data/goal/goal_repository.dart';
import '../model/complete_goal_model.dart';

final AutoDisposeProvider<GetCompleteGoalListUseCase>
    getCompleteGoalListUseCaseProvider =
    Provider.autoDispose<GetCompleteGoalListUseCase>(
  (AutoDisposeRef<GetCompleteGoalListUseCase> ref) =>
      GetCompleteGoalListUseCase(
    goalRepository: ref.read(goalRepositoryProvider),
  ),
);

class GetCompleteGoalListUseCase {
  final GoalRepository _goalRepository;

  GetCompleteGoalListUseCase({
    required GoalRepository goalRepository,
  }) : _goalRepository = goalRepository;

  Future<UseCaseResult<List<CompleteGoalModel>>> call() async {
    final RepositoryResult<List<CompleteGoalEntity>> repositoryResult =
        await _goalRepository.getCompleteGoals();

    return switch (repositoryResult) {
      SuccessRepositoryResult<List<CompleteGoalEntity>>() =>
        SuccessUseCaseResult<List<CompleteGoalModel>>(
          data: List<CompleteGoalModel>.generate(
            repositoryResult.data.length,
            (int index) => CompleteGoalModel.fromEntity(
              entity: repositoryResult.data[index],
            ),
          ),
        ),
      FailureRepositoryResult<List<CompleteGoalEntity>>() =>
        FailureUseCaseResult<List<CompleteGoalModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
