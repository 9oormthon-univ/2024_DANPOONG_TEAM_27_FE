import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/example/entity/example_entity.dart';
import '../../../data/example/example_repository.dart';
import '../model/example_model.dart';

final AutoDisposeProvider<GetExampleUseCase> getExampleUseCaseProvider =
    Provider.autoDispose<GetExampleUseCase>(
  (AutoDisposeRef<GetExampleUseCase> ref) => GetExampleUseCase(
    exampleRepository: ref.read(exampleRepositoryProvider),
  ),
);

class GetExampleUseCase {
  final ExampleRepository _exampleRepository;
  GetExampleUseCase({
    required ExampleRepository exampleRepository,
  }) : _exampleRepository = exampleRepository;

  Future<UseCaseResult<ExampleModel>> call({
    required String title,
  }) async {
    final RepositoryResult<ExampleEntity> repositoryResult =
        await _exampleRepository.getExample(
            // 기본 9개로 고정
            title: title);
    return switch (repositoryResult) {
      SuccessRepositoryResult<ExampleEntity>() =>
        SuccessUseCaseResult<ExampleModel>(
          data: ExampleModel.fromEntity(
            entity: repositoryResult.data,
          ),
          // 받아오는 데이터가 리스트일 경우
          // ExampleModel.generate(
          //   repositoryResult.data.contents.length,
          //   (int index) => ExampleModel.fromEntity(
          //     entity: repositoryResult.data.contents[index],
          //   ),
          // ),
        ),
      FailureRepositoryResult<ExampleEntity>() =>
        FailureUseCaseResult<ExampleModel>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
