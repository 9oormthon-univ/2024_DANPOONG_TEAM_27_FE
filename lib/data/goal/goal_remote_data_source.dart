import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/common/data/entity_form.dart';
import '../../core/common/data/list_entity_form.dart';
import '../../service/network/dio_service.dart';
import 'entity/goal_detail_entity.dart';
import 'entity/goal_entity.dart';
import 'entity/goal_summary_entity.dart';
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
  Future<ListEntityForm<GoalEntity>> getGoalList();

  @POST('/goal')
  Future<void> createGoal({
    @Body() required CreateGoalRequestBody body,
  });

  @POST('/goal/{goal_id}')
  Future<void> toggleGoalComplete({
    @Path('goal_id') required int goalId,
  });

  @DELETE('/goal/{goal_id}')
  Future<void> deleteGoal({
    @Path('goal_id') required int goalId,
  });

  @GET('/goal/mypage')
  Future<ListEntityForm<GoalSummaryEntity>> getGoalSummaryList();

  @GET('/goal/mypage/{goal_id}')
  Future<EntityForm<GoalDetailEntity>> getGoalSummary({
    @Path('goal_id') required int goalId,
  });
}
