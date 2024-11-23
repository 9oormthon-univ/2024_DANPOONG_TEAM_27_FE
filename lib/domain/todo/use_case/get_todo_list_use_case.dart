import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/data/list_entity_form.dart';
import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/entity/todo_entity.dart';
import '../../../data/todo/todo_repository.dart';
import '../model/todo_model.dart';

final AutoDisposeProvider<GetTodoListUseCase> getTodoListUseCaseProvider =
    Provider.autoDispose<GetTodoListUseCase>(
  (AutoDisposeRef<GetTodoListUseCase> ref) => GetTodoListUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class GetTodoListUseCase {
  final TodoRepository _todoRepository;
  GetTodoListUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<List<TodoModel>>> call({
    required int goalId,
  }) async {
    final RepositoryResult<ListEntityForm<TodoEntity>> repositoryResult =
        await _todoRepository.getTodoList(goalId: goalId);

    final DateTime today = DateTime.now();

    return switch (repositoryResult) {
      SuccessRepositoryResult<ListEntityForm<TodoEntity>>() =>
        SuccessUseCaseResult<List<TodoModel>>(
          data: repositoryResult.data.data
              .where(
                (TodoEntity entity) =>
                    entity.year == today.year &&
                    entity.month == today.month &&
                    entity.day == today.day,
              )
              .map(
                (TodoEntity e) => TodoModel.fromEntity(entity: e),
              )
              .toList(),
        ),
      FailureRepositoryResult<ListEntityForm<TodoEntity>>() =>
        FailureUseCaseResult<List<TodoModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
