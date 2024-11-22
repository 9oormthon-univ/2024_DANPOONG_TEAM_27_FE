import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/suggestion_goal_entity.dart';
import 'onboarding_remote_data_source.dart';

final Provider<OnboardingRepository> onboardingRepositoryProvider =
    Provider<OnboardingRepository>(
  (ProviderRef<OnboardingRepository> ref) =>
      OnboardingRepository(ref.watch(onboardingRemoteDataSourceProvider)),
);

class OnboardingRepository extends Repository {
  const OnboardingRepository(this._onboardingRemoteDataSource);

  final OnboardingRemoteDataSource _onboardingRemoteDataSource;

  Future<RepositoryResult<List<SuggestionGoalEntity>>>
      getSuggestionGoals() async {
    try {
      return SuccessRepositoryResult<List<SuggestionGoalEntity>>(
        data: await _onboardingRemoteDataSource.getTodoList(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<List<SuggestionGoalEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<List<SuggestionGoalEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<List<SuggestionGoalEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }
}
