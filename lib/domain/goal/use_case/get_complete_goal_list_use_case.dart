import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/data/list_entity_form.dart';
import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/goal/entity/goal_summary_entity.dart';
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
    final RepositoryResult<ListEntityForm<GoalSummaryEntity>> repositoryResult =
        await _goalRepository.getGoalSummaryList();

    return switch (repositoryResult) {
      SuccessRepositoryResult<ListEntityForm<GoalSummaryEntity>>(
        data: final ListEntityForm data
      ) =>
        SuccessUseCaseResult<List<CompleteGoalModel>>(
          data: data.data
              .map((entity) => CompleteGoalModel(
                    goalId: entity.goalId,
                    name: entity.name,
                    countSuccessTodo: entity.countSuccessTodo,
                    characterWidgetList: null,
                    opened: false,
                    startMonth: null,
                    startDay: null,
                    endYear: null,
                    endMonth: null,
                    endDay: null,
                    startYear: null,
                  ))
              .toList(),
        ),
      FailureRepositoryResult() =>
        FailureUseCaseResult<List<CompleteGoalModel>>(
          message: repositoryResult.messages?.firstOrNull,
        ),
    };
  }
}
