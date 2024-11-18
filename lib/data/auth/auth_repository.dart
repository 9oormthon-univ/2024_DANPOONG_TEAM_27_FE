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

  Future<RepositoryResult<AuthTokenEntity>> signIn({
    required String id,
    required String password,
  }) async {
    try {
      return SuccessRepositoryResult<AuthTokenEntity>(
        data: await _authRemoteDataSource.signIn(
          id: id,
          password: password,
        ),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        404 => FailureRepositoryResult<AuthTokenEntity>(
            error: e,
            messages: <String>['이메일 또는 비밀번호를 확인해 주세요.'],
          ),
        _ => FailureRepositoryResult<AuthTokenEntity>(
            error: e,
            messages: <String>['로그인 요청 실패'],
          ),
      };
    }
  }

  Future<RepositoryResult<AuthTokenEntity>> signUp({
    required String id,
    required String password,
  }) async {
    try {
      return SuccessRepositoryResult<AuthTokenEntity>(
        data: await _authRemoteDataSource.signUp(
          id: id,
          name: id,
          password: password,
        ),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        404 => FailureRepositoryResult<AuthTokenEntity>(
            error: e,
            messages: <String>['이메일 또는 비밀번호를 확인해 주세요.'],
          ),
        _ => FailureRepositoryResult<AuthTokenEntity>(
            error: e,
            messages: <String>['로그인 요청 실패'],
          ),
      };
    }
  }

  Future<RepositoryResult<void>> checkDuplication({
    required String id,
  }) async {
    try {
      await _authRemoteDataSource.checkDuplicatedId(
        id: id,
      );
      return const SuccessRepositoryResult<void>(data: null);
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        409 => FailureRepositoryResult<AuthTokenEntity>(
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
