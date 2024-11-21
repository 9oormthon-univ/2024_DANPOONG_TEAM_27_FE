import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/birth_info_entity.dart';
import 'entity/login_info_entity.dart';
import 'user_remote_data_source.dart';

final Provider<UserRepository> userRepositoryProvider =
    Provider<UserRepository>(
  (ProviderRef<UserRepository> ref) =>
      UserRepository(ref.watch(userRemoteDataSourceProvider)),
);

class UserRepository extends Repository {
  const UserRepository(this._userRemoteDataSource);

  final UserRemoteDataSource _userRemoteDataSource;

  Future<RepositoryResult<BirthInfoEntity>> getUserBirthInfo() async {
    try {
      return SuccessRepositoryResult<BirthInfoEntity>(
        data: await _userRemoteDataSource.getUserBirthInfo(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<BirthInfoEntity>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<BirthInfoEntity>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<BirthInfoEntity>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<LoginInfoEntity>> getUserLoginInfo() async {
    try {
      return SuccessRepositoryResult<LoginInfoEntity>(
        data: await _userRemoteDataSource.getUserLoginInfo(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<LoginInfoEntity>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<LoginInfoEntity>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<LoginInfoEntity>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<BirthInfoEntity>> getUser({
    required String title,
  }) async {
    try {
      return SuccessRepositoryResult<BirthInfoEntity>(
        data: await _userRemoteDataSource.getUserBirthInfo(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<BirthInfoEntity>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<BirthInfoEntity>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<BirthInfoEntity>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }
}
