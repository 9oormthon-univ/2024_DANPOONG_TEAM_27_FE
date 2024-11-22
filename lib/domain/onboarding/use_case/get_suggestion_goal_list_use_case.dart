import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<UseCaseResult<List<SuggestionGoalModel>>> call() async {
    final RepositoryResult<List<SuggestionGoalEntity>> repositoryResult =
        await _onboardingRepository.getSuggestionGoals();

    return switch (repositoryResult) {
      SuccessRepositoryResult<List<SuggestionGoalEntity>>() =>
        SuccessUseCaseResult<List<SuggestionGoalModel>>(
          data: repositoryResult.data
              .map((SuggestionGoalEntity e) =>
                  SuggestionGoalModel.fromEntity(entity: e))
              .toList(),
        ),
      FailureRepositoryResult<List<SuggestionGoalEntity>>() =>
        FailureUseCaseResult<List<SuggestionGoalModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
