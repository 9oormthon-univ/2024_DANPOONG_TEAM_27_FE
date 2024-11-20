import 'package:booklog/core/loading_status.dart';
import 'package:booklog/ui/common/consts/assets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'goal_complete_state.dart';


final goalCompleteViewModelProvider =
    StateNotifierProvider<GoalCompleteViewModel, GoalCompleteState>(
  (ref) => GoalCompleteViewModel(),
);

class GoalCompleteViewModel extends StateNotifier<GoalCompleteState> {
  GoalCompleteViewModel() : super(GoalCompleteState.init());

  Future<void> init() async {
    state = state.copyWith(loadingStatus: LoadingStatus.loading);
    
    try {
      await _loadGoalCompleteData();
      state = state.copyWith(loadingStatus: LoadingStatus.success);
    } catch (e) {
      state = state.copyWith(loadingStatus: LoadingStatus.error);
    }
  }

  Future<void> _loadGoalCompleteData() async {
    // 캐릭터 타입에 따라 다른 애니메이션 설정
    state = state.copyWith(
      kingName: '킹쥐',
      startDate: DateTime(2024, 11, 15),
      endDate: DateTime(2024, 12, 15),
      completedMissions: 74,
      animalCounts: {
        Assets.mouseFrame: 12,
        Assets.cowFrame: 9,
        Assets.tigerFrame: 5,
        Assets.rabbitFrame: 6,
        Assets.dragonFrame: 9,
        Assets.snakeFrame: 4,
        Assets.horseFrame: 5,
        Assets.sheepFrame: 3,
        Assets.monkeyFrame: 4,
        Assets.chickenFrame: 7,
        Assets.dogFrame: 8,
        Assets.pigFrame: 2,
      },
      characterAppearAnimation: Assets.kingMouseAppear,
      characterStopAnimation: Assets.kingMouseStop,
    );
  }

  int getDurationInDays() {
    return state.endDate.difference(state.startDate).inDays;
  }
} 