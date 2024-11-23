import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/data/entity_form.dart';
import '../../core/common/data/list_entity_form.dart';
import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/goal_detail_entity.dart';
import 'entity/goal_entity.dart';
import 'entity/goal_summary_entity.dart';
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

  Future<RepositoryResult<ListEntityForm<GoalEntity>>> getGoalList() async {
    try {
      return SuccessRepositoryResult<ListEntityForm<GoalEntity>>(
        data: await _goalRemoteDataSource.getGoalList(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;
      return switch (statusCode) {
        400 => FailureRepositoryResult<ListEntityForm<GoalEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<ListEntityForm<GoalEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<ListEntityForm<GoalEntity>>(
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

  Future<RepositoryResult<void>> deleteGoal({
    required int goalId,
  }) async {
    try {
      await _goalRemoteDataSource.deleteGoal(
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

  Future<RepositoryResult<ListEntityForm<GoalSummaryEntity>>>
      getGoalSummaryList() async {
    try {
      return SuccessRepositoryResult<ListEntityForm<GoalSummaryEntity>>(
        data: await _goalRemoteDataSource.getGoalSummaryList(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;
      return switch (statusCode) {
        400 => FailureRepositoryResult<ListEntityForm<GoalSummaryEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<ListEntityForm<GoalSummaryEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<ListEntityForm<GoalSummaryEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<EntityForm<GoalDetailEntity>>> getGoalSummary({
    required int goalId,
  }) async {
    try {
      return SuccessRepositoryResult<EntityForm<GoalDetailEntity>>(
        data: await _goalRemoteDataSource.getGoalSummary(goalId: goalId),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;
      return switch (statusCode) {
        400 => FailureRepositoryResult<EntityForm<GoalDetailEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<EntityForm<GoalDetailEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<EntityForm<GoalDetailEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }
}
