import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/todo_repository.dart';

final AutoDisposeProvider<UpdateTodoUseCase> updateTodoUseCaseProvider =
Provider.autoDispose<UpdateTodoUseCase>(
      (AutoDisposeRef<UpdateTodoUseCase> ref) => UpdateTodoUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class UpdateTodoUseCase {
  final TodoRepository _todoRepository;
  UpdateTodoUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<void>> call({
    required int todoId,
    required String name,
  }) async {
    final RepositoryResult<void> repositoryResult =
    await _todoRepository.updateTodo(
      todoId: todoId,
      name: name,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<void>() => const SuccessUseCaseResult<void>(
        data: null,
      ),
      FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
        message: repositoryResult.messages?[0],
      )
    };
  }
}
