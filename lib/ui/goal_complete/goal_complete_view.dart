import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/loading_status.dart';
import '../../routes/routes.dart';
import '../../theme/luckit_colors.dart';
import '../../theme/luckit_typos.dart';
import '../common/widgets/bottom_button_widget.dart';
import '../common/widgets/rounded_grey_text_widget.dart';
import 'goal_complete_state.dart';
import 'goal_complete_view_model.dart';
import 'widget/king_animation.dart';
import 'widget/together_animal.dart';

class GoalCompleteView extends ConsumerStatefulWidget {
  const GoalCompleteView({super.key});

  @override
  ConsumerState<GoalCompleteView> createState() => _KingAppearScreenState();
}

class _KingAppearScreenState extends ConsumerState<GoalCompleteView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(goalCompleteViewModelProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoalCompleteState state = ref.watch(goalCompleteViewModelProvider);
    final GoalCompleteViewModel viewModel =
        ref.read(goalCompleteViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      body: state.loadingStatus == LoadingStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: KingAnimation(
                              appearAnimation: state.characterAppearAnimation,
                              stopAnimation: state.characterStopAnimation,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${state.kingName}(이)가 농장에 왔어요!',
                            style: LuckitTypos.suitEB32.copyWith(
                                fontSize: 24, color: LuckitColors.main),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${state.startDate.year}년 ${state.startDate.month}월 ${state.startDate.day}일 - '
                            '${state.endDate.year}년 ${state.endDate.month}월 ${state.endDate.day}일',
                            style: LuckitTypos.suitSB16
                                .copyWith(color: LuckitColors.gray80),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundedGreyTextWidget(
                                  label:
                                      '진행 기간 ${viewModel.getDurationInDays()}일'),
                              const SizedBox(width: 16),
                              RoundedGreyTextWidget(
                                  label: '완료한 미션 12개'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '함께 한 동물',
                            style: LuckitTypos.suitSB16
                                .copyWith(color: LuckitColors.main),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: TogetherAnimal(
                              animalCounts: state.animalCounts,
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BottomButtonWidget(
                    onPressed: () => context.go(Routes.home.path),
                    activated: true,
                    label: '홈으로 돌아가기',
                  ),
                ),
              ],
            ),
    );
  }
}
