import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'auth_remote_data_source.dart';
import 'entity/auth_token_entity.dart';

final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>(
  (ProviderRef<AuthRepository> ref) => AuthRepository(
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
  ),
);

class AuthRepository extends Repository {
  final AuthRemoteDataSource _authRemoteDataSource;
  const AuthRepository({
    required AuthRemoteDataSource authRemoteDataSource,
  }) : _authRemoteDataSource = authRemoteDataSource;

  Future<RepositoryResult<AuthTokenEntity>> kakaoCallback({
    required String code,
  }) async {
    try {
      return SuccessRepositoryResult<AuthTokenEntity>(
        data: await _authRemoteDataSource.kakaoCallback(code: code),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<AuthTokenEntity>(
            error: e,
            messages: <String>['아이디가 중복됩니다.'],
          ),
        _ => FailureRepositoryResult<AuthTokenEntity>(
            error: e,
            messages: <String>['아이디 중복 검사 요청 실패'],
          ),
      };
    }
  }
}
