import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/data/list_entity_form.dart';
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

  Future<RepositoryResult<ListEntityForm<SuggestionGoalEntity>>>
      getSuggestionGoals() async {
    try {
      return SuccessRepositoryResult<ListEntityForm<SuggestionGoalEntity>>(
        data: await _onboardingRemoteDataSource.getSuggestionGoalList(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<ListEntityForm<SuggestionGoalEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<ListEntityForm<SuggestionGoalEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<ListEntityForm<SuggestionGoalEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }
}
