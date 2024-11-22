import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../service/network/dio_service.dart';
import 'entity/suggestion_goal_entity.dart';

part 'generated/onboarding_remote_data_source.g.dart';

final Provider<OnboardingRemoteDataSource> onboardingRemoteDataSourceProvider =
    Provider<OnboardingRemoteDataSource>(
  (ProviderRef<OnboardingRemoteDataSource> ref) =>
      OnboardingRemoteDataSource(ref.read(dioServiceProvider)),
);

@RestApi()
abstract class OnboardingRemoteDataSource {
  factory OnboardingRemoteDataSource(Dio dio) = _OnboardingRemoteDataSource;

  @GET('/fortune')
  Future<List<SuggestionGoalEntity>> getSuggestionGoalList();
}
