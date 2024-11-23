import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/data/list_entity_form.dart';
import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/onboarding/onboarding_repository.dart';
import '../../../data/onboarding/entity/suggestion_goal_entity.dart';
import '../model/suggestion_goal_model.dart';

final AutoDisposeProvider<GetSuggestionGoalListUseCase>
    getSuggestionGoalListUseCaseProvider =
    Provider.autoDispose<GetSuggestionGoalListUseCase>(
  (AutoDisposeRef<GetSuggestionGoalListUseCase> ref) =>
      GetSuggestionGoalListUseCase(
    onboardingRepository: ref.read(onboardingRepositoryProvider),
  ),
);

class GetSuggestionGoalListUseCase {
  final OnboardingRepository _onboardingRepository;

  GetSuggestionGoalListUseCase({
    required OnboardingRepository onboardingRepository,
  }) : _onboardingRepository = onboardingRepository;

  Future<UseCaseResult<List<GoalModel>>> call() async {
    final RepositoryResult<ListEntityForm<SuggestionGoalEntity>> repositoryResult =
        await _onboardingRepository.getSuggestionGoals();

    return switch (repositoryResult) {
      SuccessRepositoryResult<ListEntityForm<SuggestionGoalEntity>>() =>
        SuccessUseCaseResult<List<GoalModel>>(
          data: List.generate(repositoryResult.data.data.length, (index) {
            return GoalModel.fromEntity(
                entity: repositoryResult.data.data[index]);
          }),
        ),
      FailureRepositoryResult<ListEntityForm<SuggestionGoalEntity>>() =>
        FailureUseCaseResult<List<GoalModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
