import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'request_body/register_birth_info_request_body.dart';

import '../../core/common/data/entity_form.dart';
import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import 'entity/birth_info_entity.dart';
import 'entity/login_info_entity.dart';
import 'user_remote_data_source.dart';

final Provider<UserRepository> userRepositoryProvider =
    Provider<UserRepository>(
  (ProviderRef<UserRepository> ref) =>
      UserRepository(ref.read(userRemoteDataSourceProvider)),
);

class UserRepository extends Repository {
  const UserRepository(this._userRemoteDataSource);

  final UserRemoteDataSource _userRemoteDataSource;

  Future<RepositoryResult<EntityForm<BirthInfoEntity>>>
      getUserBirthInfo() async {
    try {
      return SuccessRepositoryResult<EntityForm<BirthInfoEntity>>(
        data: await _userRemoteDataSource.getUserBirthInfo(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<EntityForm<BirthInfoEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<EntityForm<BirthInfoEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<EntityForm<BirthInfoEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<EntityForm<LoginInfoEntity>>>
      getUserLoginInfo() async {
    try {
      return SuccessRepositoryResult<EntityForm<LoginInfoEntity>>(
        data: await _userRemoteDataSource.getUserLoginInfo(),
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<EntityForm<LoginInfoEntity>>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<EntityForm<LoginInfoEntity>>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<EntityForm<LoginInfoEntity>>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<void>> registerUserBirthInfo({
    required String gender,
    required String solarOrLunar,
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
    required bool unknownTime,
  }) async {
    try {
      await _userRemoteDataSource.registerUserBirthInfo(
        body: RegisterBirthInfoRequestBody(
          gender: gender,
          solarOrLunar: solarOrLunar,
          year: year,
          month: month,
          day: day,
          hour: hour,
          minute: minute,
          unknownTime: unknownTime,
        ),
      );

      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<void>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }

  Future<RepositoryResult<void>> registerBirthInfo({
    required RegisterBirthInfoRequestBody body,
  }) async {
    try {
      await _userRemoteDataSource.registerUserBirthInfo(
        body: body,
      );
      return const SuccessRepositoryResult<void>(data: null);
    } on DioException catch (e) {
      final int? statusCode = e.response?.statusCode;

      return switch (statusCode) {
        400 => FailureRepositoryResult<String>(
            error: e,
            messages: <String>['Bad Request'],
          ),
        401 => FailureRepositoryResult<String>(
            error: e,
            messages: <String>['Unauthorized access'],
          ),
        _ => FailureRepositoryResult<String>(
            error: e,
            messages: <String>['정의되지 않은 오류'],
          ),
      };
    }
  }
}
