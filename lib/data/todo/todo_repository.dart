import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luckit/data/todo/request_body/update_todo_request_body.dart';

import '../../core/common/data/list_entity_form.dart';
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

  Future<RepositoryResult<ListEntityForm<TodoEntity>>> getTodoList({
    required int goalId,
  }) async {
    try {
      return SuccessRepositoryResult<ListEntityForm<TodoEntity>>(
        data: await _todoRemoteDataSource.getTodoList(
          goalId: goalId,
        ),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<ListEntityForm<TodoEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<ListEntityForm<TodoEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<ListEntityForm<TodoEntity>>(
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

  Future<RepositoryResult<void>> updateTodo({
    required int todoId,
    required String name,
  }) async {
    try {
      await _todoRemoteDataSource.updateTodo(
        body: UpdateTodoRequestBody(
          todoId: todoId,
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

  Future<RepositoryResult<void>> deleteTodo({
    required int todoId,
  }) async {
    try {
      await _todoRemoteDataSource.deleteTodo(todoId: todoId);
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

  Future<RepositoryResult<ListEntityForm<int>>> getTodoGraphData({
    required int year,
    required int month,
  }) async {
    try {
      return SuccessRepositoryResult<ListEntityForm<int>>(
        data: await _todoRemoteDataSource.getTodoGrahpData(
          year: year,
          month: month,
        ),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<ListEntityForm<int>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<ListEntityForm<int>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<ListEntityForm<int>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }
}
