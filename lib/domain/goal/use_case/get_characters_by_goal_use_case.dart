import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/todo_repository.dart';
import '../model/complete_goal_characters_model.dart';

final AutoDisposeProvider<CharactersByGoalUseCaseProvider>
    getCharactersByGoalUseCaseProvider =
    Provider.autoDispose<CharactersByGoalUseCaseProvider>(
  (AutoDisposeRef<CharactersByGoalUseCaseProvider> ref) =>
      CharactersByGoalUseCaseProvider(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class CharactersByGoalUseCaseProvider {
  final TodoRepository _todoRepository;

  CharactersByGoalUseCaseProvider({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<CompleteGoalCharactersModel>> call({
    required int goalId,
  }) async {
    final List<int> repositoryResult = <int>[
      12,
      9,
      5,
      15,
      49,
      12,
      0,
      3,
      6,
      9,
      23,
      4
    ];
    return SuccessUseCaseResult<CompleteGoalCharactersModel>(
      data: CompleteGoalCharactersModel.fromEntity(entity: repositoryResult),
    );
    //   return switch (repositoryResult) {
    //     SuccessRepositoryResult<void>() => const SuccessUseCaseResult<void>(
    //       data: null,
    //     ),
    //     FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
    //       message: repositoryResult.messages?[0],
    //     )
    //   };
    // }
  }
}
