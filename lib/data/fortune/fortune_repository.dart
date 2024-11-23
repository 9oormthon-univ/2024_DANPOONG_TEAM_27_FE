import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/data/entity_form.dart';
import '../../core/common/data/list_entity_form.dart';
import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/fortune_entity.dart';
import 'fortune_remote_data_source.dart';

final Provider<FortuneRepository> fortuneRepositoryProvider =
    Provider<FortuneRepository>(
  (ProviderRef<FortuneRepository> ref) =>
      FortuneRepository(ref.watch(fortuneRemoteDataSourceProvider)),
);

class FortuneRepository extends Repository {
  const FortuneRepository(this._fortuneRemoteDataSource);

  final FortuneRemoteDataSource _fortuneRemoteDataSource;

  Future<RepositoryResult<EntityForm<FortuneEntity>>> getFortune() async {
    try {
      return SuccessRepositoryResult<EntityForm<FortuneEntity>>(
        data: await _fortuneRemoteDataSource.getFortune(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<EntityForm<FortuneEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<EntityForm<FortuneEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<EntityForm<FortuneEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }
}
