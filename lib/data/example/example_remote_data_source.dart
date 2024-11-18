import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../service/network/dio_service.dart';
import 'entity/example_entity.dart';

part 'generated/example_remote_data_source.g.dart';

final Provider<ExampleRemoteDataSource> exampleRemoteDataSourceProvider =
    Provider<ExampleRemoteDataSource>(
  (ProviderRef<ExampleRemoteDataSource> ref) =>
      ExampleRemoteDataSource(ref.read(dioServiceProvider)),
);

@RestApi()
abstract class ExampleRemoteDataSource {
  factory ExampleRemoteDataSource(Dio dio) = _ExampleRemoteDataSource;

  @GET('/expamle')
  Future<ExampleEntity> getExample({
    @Query('title') required String title,
  });
}
