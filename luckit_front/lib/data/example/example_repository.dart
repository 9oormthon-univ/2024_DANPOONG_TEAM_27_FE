import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/example_entity.dart';
import 'example_remote_data_source.dart';

final Provider<ExampleRepository> exampleRepositoryProvider =
    Provider<ExampleRepository>(
  (ProviderRef<ExampleRepository> ref) =>
      ExampleRepository(ref.watch(exampleRemoteDataSourceProvider)),
);

class ExampleRepository extends Repository {
  const ExampleRepository(this._exampleRemoteDataSource);

  final ExampleRemoteDataSource _exampleRemoteDataSource;

  Future<RepositoryResult<ExampleEntity>> getExample({
    required String title,
  }) async {
    try {
      return SuccessRepositoryResult<ExampleEntity>(
        data: await _exampleRemoteDataSource.getExample(
          title: title,
        ),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        _ => FailureRepositoryResult<ExampleEntity>(
            error: e,
            messages: <String>['데이터 불러오는 과정에 오류가 있습니다'],
          ),
      };
    }
  }
}
