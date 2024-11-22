import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../service/network/dio_service.dart';
import 'entity/fortune_entity.dart';

part 'generated/fortune_remote_data_source.g.dart';

final Provider<FortuneRemoteDataSource> fortuneRemoteDataSourceProvider =
    Provider<FortuneRemoteDataSource>(
  (ProviderRef<FortuneRemoteDataSource> ref) =>
      FortuneRemoteDataSource(ref.read(dioServiceProvider)),
);

@RestApi()
abstract class FortuneRemoteDataSource {
  factory FortuneRemoteDataSource(Dio dio) = _FortuneRemoteDataSource;

  @GET('/api/v1/fortune/daily')
  Future<FortuneEntity> getFortune();
  
}
