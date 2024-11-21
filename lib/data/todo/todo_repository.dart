import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/todo_entity.dart';
import 'request_body/create_todo_request_body.dart';
import 'todo_remote_data_source.dart';

final Provider<TodoRepository> todoRepositoryProvider =
    Provider<TodoRepository>(
  (ProviderRef<TodoRepository> ref) =>
      TodoRepository(ref.watch(todoRemoteDataSourceProvider)),
);

class TodoRepository extends Repository {
  const TodoRepository(this._todoRemoteDataSource);

  final TodoRemoteDataSource _todoRemoteDataSource;

  Future<RepositoryResult<List<TodoEntity>>> getTodoList({
    required int goalId,
  }) async {
    try {
      return SuccessRepositoryResult<List<TodoEntity>>(
        data: await _todoRemoteDataSource.getTodoList(
          goalId: goalId,
        ),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<List<TodoEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<List<TodoEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<List<TodoEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<void>> createTodo({
    required int goalId,
    required String name,
  }) async {
    try {
      await _todoRemoteDataSource.createTodo(
        body: CreateTodoRequestBody(
          goalId: goalId,
          name: name,
        ),
      );
      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<void>> toggleTodoComplete({
    required int todoId,
  }) async {
    try {
      await _todoRemoteDataSource.toggleTodoComplete(todoId: todoId);
      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }
}
