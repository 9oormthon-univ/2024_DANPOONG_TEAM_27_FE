import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/common/data/entity_form.dart';
import '../../service/network/dio_service.dart';
import 'entity/birth_info_entity.dart';
import 'entity/login_info_entity.dart';
import 'request_body/register_birth_info_request_body.dart';

part 'generated/user_remote_data_source.g.dart';

final Provider<UserRemoteDataSource> userRemoteDataSourceProvider =
    Provider<UserRemoteDataSource>(
  (ProviderRef<UserRemoteDataSource> ref) =>
      UserRemoteDataSource(ref.read(dioServiceProvider)),
);

@RestApi()
abstract class UserRemoteDataSource {
  factory UserRemoteDataSource(Dio dio) = _UserRemoteDataSource;

  @GET('/user/fortune')
  Future<EntityForm<BirthInfoEntity>> getUserBirthInfo();

  @GET('/user')
  Future<EntityForm<LoginInfoEntity>> getUserLoginInfo();

  @POST('/user/fortune')
  Future<void> registerUserBirthInfo({
    @Body() required RegisterBirthInfoRequestBody body,
  });
}
