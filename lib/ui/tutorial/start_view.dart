import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../theme/luckit_colors.dart';
import '../../theme/luckit_typos.dart';
import '../onboarding/widgets/onboarding_bottom_button.dart';
import 'widgets/tutorial_game.dart';

class StartView extends ConsumerWidget {
  final VoidCallback onNextPage;
  
  const StartView({
    required this.onNextPage,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double gameHeight = MediaQuery.of(context).size.width / 375 * 300;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 126),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '작은 성취로\n꾸준히 성장해보세요',
                  style: LuckitTypos.suitEB32.copyWith(
                    color: LuckitColors.main,
                  ),
                ),
                Text(
                  '운세 기반 맞춤 목표와 미션으로\n꾸준한 성취를 통해 성장을 도와드려요.',
                  style: LuckitTypos.suitR16.copyWith(
                    color: LuckitColors.gray80,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: gameHeight,
            child: const TutorialGame(
              speed: 0.1,
              characterGap: 120,
            ),
          ),
          const Expanded(child: SizedBox()),
          OnboardingBottomButton(
            onPressed: onNextPage,
            activated: true,
            label: '정보 입력하러 가기',
          ),
        ],
      ),
    );
  }
}
