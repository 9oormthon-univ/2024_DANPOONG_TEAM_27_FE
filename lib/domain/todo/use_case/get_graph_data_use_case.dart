import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/data/list_entity_form.dart';
import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/todo_repository.dart';
import '../model/graph_data_model.dart';

final AutoDisposeProvider<GetGraphDataUseCase> getGraphDataUseCaseProvider =
Provider.autoDispose<GetGraphDataUseCase>(
      (AutoDisposeRef<GetGraphDataUseCase> ref) => GetGraphDataUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class GetGraphDataUseCase {
  final TodoRepository _todoRepository;

  GetGraphDataUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<GraphDataModel>> call({
    required int year,
    required int month,
  }) async {
    final RepositoryResult<ListEntityForm<int>> repositoryResult =
    await _todoRepository.getTodoGraphData(
      year: year,
      month: month,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<ListEntityForm<int>>() => SuccessUseCaseResult<GraphDataModel>(
        data: GraphDataModel.fromEntity(
          rawDataList: repositoryResult.data.data,
          queryYear: year,
          queryMonth: month,
        ),
      ),
      FailureRepositoryResult<ListEntityForm<int>>() => FailureUseCaseResult<GraphDataModel>(
        message: repositoryResult.messages?.firstOrNull,
      ),
    };
  }
}