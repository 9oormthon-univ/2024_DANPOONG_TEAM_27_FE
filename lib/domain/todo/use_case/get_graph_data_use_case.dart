import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  final List<int> tempGraphData = <int>[5, 7, 1, 8, 10, 3, 3];

  Future<UseCaseResult<GraphDataModel>> call({
    required int year,
    required int month,
  }) async =>
      SuccessUseCaseResult<GraphDataModel>(
        data: GraphDataModel.fromEntity(rawDataList: tempGraphData),
      );
}
