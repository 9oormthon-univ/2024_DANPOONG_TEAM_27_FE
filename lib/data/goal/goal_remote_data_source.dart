import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../service/network/dio_service.dart';
import 'entity/goal_entity.dart';
import 'request_body/create_goal_request_body.dart';

part 'generated/goal_remote_data_source.g.dart';

final Provider<GoalRemoteDataSource> goalRemoteDataSourceProvider =
    Provider<GoalRemoteDataSource>(
  (ProviderRef<GoalRemoteDataSource> ref) =>
      GoalRemoteDataSource(ref.read(dioServiceProvider)),
);

@RestApi()
abstract class GoalRemoteDataSource {
  factory GoalRemoteDataSource(Dio dio) = _GoalRemoteDataSource;

  @GET('/goal')
  Future<List<GoalEntity>> getGoalList();

  @POST('/goal')
  Future<void> createGoal({
    @Body() required CreateGoalRequestBody body,
  });

  @POST('/goal/{goal_id}')
  Future<void> toggleGoalComplete({
    @Path('goal_id') required int goalId,
  });
}
