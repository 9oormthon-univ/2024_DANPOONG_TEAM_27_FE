import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/todo_repository.dart';

final AutoDisposeProvider<CreateTodoUseCase> createTodoUseCaseProvider =
    Provider.autoDispose<CreateTodoUseCase>(
  (AutoDisposeRef<CreateTodoUseCase> ref) => CreateTodoUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class CreateTodoUseCase {
  final TodoRepository _todoRepository;
  CreateTodoUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<void>> call({
    required int goalId,
    required String name,
  }) async {
    final RepositoryResult<void> repositoryResult =
        await _todoRepository.createTodo(
      goalId: goalId,
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
