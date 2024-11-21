import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../../game/horizontal_walking_game.dart';
import '../../goal_complete/widget/king_animation.dart';

class TutorialText extends StatelessWidget {
  final String text;

  const TutorialText(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: LuckitTypos.suitSB16,
        ),
      );
}

class TutorialFirstPage extends StatelessWidget {
  const TutorialFirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Expanded(child: Image.asset(Assets.tutorialFirstImage)),
          const TutorialText('복잡한 계획은 필요 없어요.\n오늘 할 일을 간단히 추천받고 바로 시작하세요.'),
        ],
      );
}

class TutorialSecondPage extends StatelessWidget {
  const TutorialSecondPage({super.key});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Image.asset(Assets.tutorialSecondImage)),
          const TutorialText('미션을 수행하면, 동물이 랜덤으로\n나만의 농장으로 이동해요.'),
        ],
      );
}

class TutorialThirdPage extends StatelessWidget {
  const TutorialThirdPage({super.key});

  @override
  Widget build(BuildContext context) => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          KingAnimation(
            appearAnimation: Assets.kingMouseAppear,
            stopAnimation: Assets.kingMouseStop,
          ),
          Spacer(),
          TutorialText('목표를 달성하면\n히든 동물을 제공해드려요.'),
        ],
      );
}

class TutorialFourthPage extends StatelessWidget {
  final HorizontalWalkingGame? game;

  const TutorialFourthPage({
    required this.game,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          if (game != null)
            SizedBox(
              height: MediaQuery.of(context).size.width / 375 * 300,
              width: double.infinity,
              child: GameWidget<HorizontalWalkingGame>(game: game!),
            )
          else Image.asset(Assets.gameBackgroundAsset),
          const Spacer(),
          const TutorialText('이제, 당신만의 목표로\n미션을 시작해보세요!'),
        ],
      );
}
