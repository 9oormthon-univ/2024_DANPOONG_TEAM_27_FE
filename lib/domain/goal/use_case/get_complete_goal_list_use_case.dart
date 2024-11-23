import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/todo_repository.dart';
import '../model/complete_goal_model.dart';

final AutoDisposeProvider<GetCompleteGoalListUseCase>
    getCompleteGoalListUseCaseProvider =
    Provider.autoDispose<GetCompleteGoalListUseCase>(
  (AutoDisposeRef<GetCompleteGoalListUseCase> ref) =>
      GetCompleteGoalListUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class GetCompleteGoalListUseCase {
  final TodoRepository _todoRepository;

  GetCompleteGoalListUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<List<CompleteGoalModel>>> call() async =>
      const SuccessUseCaseResult(data: <CompleteGoalModel>[
        CompleteGoalModel(
          goalId: 1,
          name: '안녕',
          countSuccessTodo: 100,
          characterWidgetList: null,
          opened: false,
        ),
        CompleteGoalModel(
          goalId: 2,
          name: '안녕',
          countSuccessTodo: 90,
          characterWidgetList: null,
          opened: false,
        )
      ]);

// Future<UseCaseResult<CompleteGoalModel>> call({}) async {
//   final RepositoryResult<void> repositoryResult =
//       await _todoRepository.createTodo(
//     goalId: goalId,
//     name: name,
//   );
//
//   return switch (repositoryResult) {
//     SuccessRepositoryResult<void>() =>
//       const SuccessUseCaseResult<CompleteGoalModel>(
//         data: CompleteGoalModel(
//
//         ),
//       ),
//     FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
//         message: repositoryResult.messages?[0],
//       )
//   };
// }
}
