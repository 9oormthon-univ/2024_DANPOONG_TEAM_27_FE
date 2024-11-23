import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luckit/data/todo/request_body/update_todo_request_body.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/common/data/list_entity_form.dart';
import '../../service/network/dio_service.dart';
import 'entity/todo_entity.dart';
import 'request_body/create_todo_request_body.dart';

part 'generated/todo_remote_data_source.g.dart';

final Provider<TodoRemoteDataSource> todoRemoteDataSourceProvider =
    Provider<TodoRemoteDataSource>(
  (ProviderRef<TodoRemoteDataSource> ref) =>
      TodoRemoteDataSource(ref.read(dioServiceProvider)),
);

@RestApi()
abstract class TodoRemoteDataSource {
  factory TodoRemoteDataSource(Dio dio) = _TodoRemoteDataSource;

  @GET('/todo/{goal_id}')
  Future<ListEntityForm<TodoEntity>> getTodoList({
    @Path('goal_id') required int goalId,
  });

  @POST('/todo')
  Future<void> createTodo({
    @Body() required CreateTodoRequestBody body,
  });

  @POST('/todo/{todo_id}')
  Future<void> toggleTodoComplete({
    @Path('todo_id') required int todoId,
  });

  @DELETE('/todo/{todo_id}')
  Future<void> deleteTodo({
    @Path('todo_id') required int todoId,
  });

  @POST('/todo/update')
  Future<void> updateTodo({
    @Body() required UpdateTodoRequestBody body,
  });

  @GET('/todo/graph')
  Future<ListEntityForm<int>> getTodoGrahpData({
    @Query('year') required int year,
    @Query('month') required int month,
  });
}
