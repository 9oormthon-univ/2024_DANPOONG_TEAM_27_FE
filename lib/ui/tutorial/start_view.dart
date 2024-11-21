import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../theme/luckit_colors.dart';
import '../../theme/luckit_typos.dart';
import '../common/consts/assets.dart';
import '../game/character_data.dart';
import '../game/horizontal_walking_game.dart';
import '../game/mission_character_provider.dart';
import '../onboarding/widgets/onboarding_bottom_button.dart';

class StartView extends ConsumerWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        backgroundColor: LuckitColors.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 126),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '작은 성취로\n꾸준히 성장해보세요',
                    style: LuckitTypos.suitEB32.copyWith(
                      color: LuckitColors.main,
                    ),
                  ),
                  Text(
                    '운세 기반 맞춤 목표와 미션으로\n꾸준한 성취를 통해 성장을 도와드려요.',
                    style: LuckitTypos.suitR16
                        .copyWith(color: LuckitColors.gray80),
                  ),
                ],
              ),
            ),

            //SizedBox(height: 120),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                future: initializeGame(context, ref),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  }
                  return GameWidget(game: snapshot.data!);
                },
              ),
            ),
            const Expanded(child: SizedBox()),
            OnboardingBottomButton(
              onPressed: () => context.goNamed('/onboarding/birth'),
              activated: true,
              label: '정보 입력하러 가기',
            ),
          ],
        ),
      );

  Future<HorizontalWalkingGame> initializeGame(
      BuildContext context, WidgetRef ref) async {
    final List<CharacterData> characters = ref.read(missionCharactersProvider);

    final HorizontalWalkingGame game = HorizontalWalkingGame(
      boundarySize: Vector2(MediaQuery.of(context).size.width, 200),
      characterTypes: characters,
      gameBackground: Assets.whiteBackground,
    );
    await game.onLoad();
    return game;
  }
}
