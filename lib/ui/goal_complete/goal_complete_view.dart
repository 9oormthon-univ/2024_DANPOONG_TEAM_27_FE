import 'package:booklog/core/loading_status.dart';
import 'package:booklog/ui/goal_complete/widget/king_animation.dart';
import 'package:booklog/ui/goal_complete/widget/together_animal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'goal_complete_view_model.dart';

class GoalCompleteView extends ConsumerStatefulWidget {
  const GoalCompleteView({super.key});

  @override
  ConsumerState<GoalCompleteView> createState() => _KingAppearScreenState();
}

class _KingAppearScreenState extends ConsumerState<GoalCompleteView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(goalCompleteViewModelProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(goalCompleteViewModelProvider);
    final viewModel = ref.read(goalCompleteViewModelProvider.notifier);

    if (state.loadingStatus == LoadingStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: KingAnimation(
              appearAnimation: state.characterAppearAnimation,
              stopAnimation: state.characterStopAnimation,
            ),
          ),
          const SizedBox(height: 20),
          Text('${state.kingName}(이)가 농장에 왔어요!'),
          const SizedBox(height: 20),
          Text(
              '${state.startDate.year}년 ${state.startDate.month}월 ${state.startDate.day}일 - '
              '${state.endDate.year}년 ${state.endDate.month}월 ${state.endDate.day}일'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chip(label: Text('진행 기간 ${viewModel.getDurationInDays()}일')),
              const SizedBox(width: 16),
              Chip(label: Text('완료한 미션 ${state.completedMissions}개')),
            ],
          ),
          const SizedBox(height: 20),
          const Text('함께 한 동물'),
          Center(
            child: TogetherAnimal(
              animalCounts: state.animalCounts,
            ),
          ),
        ],
      ),
    );
  }
}
