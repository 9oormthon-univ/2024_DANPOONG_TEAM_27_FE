import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

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
  Future<List<TodoEntity>> getTodoList({
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
}
