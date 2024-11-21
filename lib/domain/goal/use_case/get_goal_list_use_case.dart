import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/goal/entity/goal_entity.dart';
import '../../../data/goal/goal_repository.dart';
import '../model/goal_model.dart';

final AutoDisposeProvider<GetGoalListUseCase> getGoalListUseCaseProvider =
    Provider.autoDispose<GetGoalListUseCase>(
  (AutoDisposeRef<GetGoalListUseCase> ref) => GetGoalListUseCase(
    goalRepository: ref.read(goalRepositoryProvider),
  ),
);

class GetGoalListUseCase {
  final GoalRepository _goalRepository;
  GetGoalListUseCase({
    required GoalRepository goalRepository,
  }) : _goalRepository = goalRepository;

  Future<UseCaseResult<List<GoalModel>>> call({
    required String title,
  }) async {
    final RepositoryResult<List<GoalEntity>> repositoryResult =
        await _goalRepository.getGoalList();

    return switch (repositoryResult) {
      SuccessRepositoryResult<List<GoalEntity>>() =>
        SuccessUseCaseResult<List<GoalModel>>(
          data: List<GoalModel>.generate(
            repositoryResult.data.length,
            (int index) => GoalModel.fromEntity(
              entity: repositoryResult.data[index],
            ),
          ),
        ),
      FailureRepositoryResult<List<GoalEntity>>() =>
        FailureUseCaseResult<List<GoalModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
