import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../service/network/dio_service.dart';
import 'entity/auth_token_entity.dart';

part 'generated/auth_remote_data_source.g.dart';

final Provider<AuthRemoteDataSource> authRemoteDataSourceProvider =
    Provider<AuthRemoteDataSource>(
  (ProviderRef<AuthRemoteDataSource> ref) =>
      AuthRemoteDataSource(ref.read(dioServiceProvider)),
);

@RestApi()
// ignore: one_member_abstracts
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  /// 카카오 회원가입/로그인 콜백
  @GET('/callback')
  Future<AuthTokenEntity> kakaoCallback({
    @Query('code') required String code,
  });
}
