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
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  @FormUrlEncoded()
  @POST('/auth/signin')
  Future<AuthTokenEntity> signIn({
    @Field() required String id,
    @Field() required String password,
  });

  @FormUrlEncoded()
  @POST('/auth/signun')
  Future<AuthTokenEntity> signUp({
    @Field() required String id,
    @Field() required String name,
    @Field() required String password,
  });

  @GET('/duplication')
  Future<void> checkDuplicatedId({
    @Query('id') required String id,
  });
}
