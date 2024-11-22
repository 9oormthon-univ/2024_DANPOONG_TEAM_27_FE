import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/complete_goal_entity.dart';
import 'entity/goal_entity.dart';
import 'goal_remote_data_source.dart';
import 'request_body/create_goal_request_body.dart';

final Provider<GoalRepository> goalRepositoryProvider =
    Provider<GoalRepository>(
  (ProviderRef<GoalRepository> ref) =>
      GoalRepository(ref.watch(goalRemoteDataSourceProvider)),
);

class GoalRepository extends Repository {
  const GoalRepository(this._goalRemoteDataSource);

  final GoalRemoteDataSource _goalRemoteDataSource;

  Future<RepositoryResult<List<GoalEntity>>> getGoalList() async {
    try {
      return SuccessRepositoryResult<List<GoalEntity>>(
        data: await _goalRemoteDataSource.getGoalList(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;
      return switch (statusCode) {
        400 => FailureRepositoryResult<List<GoalEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<List<GoalEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<List<GoalEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<void>> createGoal({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      await _goalRemoteDataSource.createGoal(
        body: CreateGoalRequestBody(
          name: name,
          startDateYear: startDate.year,
          startDateMonth: startDate.month,
          startDateDay: startDate.day,
          endDateYear: endDate.year,
          endDateMonth: endDate.month,
          endDateDay: endDate.day,
        ),
      );
      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;
      return switch (statusCode) {
        400 => FailureRepositoryResult<List<GoalEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<List<GoalEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<List<GoalEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<void>> toggleGoalComplete({
    required int goalId,
  }) async {
    try {
      await _goalRemoteDataSource.toggleGoalComplete(
        goalId: goalId,
      );
      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;
      return switch (statusCode) {
        400 => FailureRepositoryResult<List<GoalEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<List<GoalEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<List<GoalEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<List<CompleteGoalEntity>>> getCompleteGoals() async {
    try {
      return SuccessRepositoryResult<List<CompleteGoalEntity>>(
        data: await _goalRemoteDataSource.getCompleteGoals(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;
      return switch (statusCode) {
        400 => FailureRepositoryResult<List<CompleteGoalEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<List<CompleteGoalEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<List<CompleteGoalEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }
}
