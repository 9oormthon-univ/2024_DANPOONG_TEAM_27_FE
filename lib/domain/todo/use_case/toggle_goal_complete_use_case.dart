import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/todo_repository.dart';

final AutoDisposeProvider<ToggleTodoCompleteUseCase>
    toggleTodoCompleteUseCaseProvider =
    Provider.autoDispose<ToggleTodoCompleteUseCase>(
  (AutoDisposeRef<ToggleTodoCompleteUseCase> ref) => ToggleTodoCompleteUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class ToggleTodoCompleteUseCase {
  final TodoRepository _todoRepository;
  ToggleTodoCompleteUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<void>> call({
    required int todoId,
  }) async {
    final RepositoryResult<void> repositoryResult =
        await _todoRepository.toggleTodoComplete(
      todoId: todoId,
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
