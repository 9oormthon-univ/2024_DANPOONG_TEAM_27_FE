import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../../game/horizontal_walking_game.dart';
import '../../goal_complete/widget/king_animation.dart';

class TutorialText extends StatelessWidget {
  final String text;

  const TutorialText(this.text, {super.key});

  @override
  Widget build(BuildContext context) =>
      Padding(
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
  Widget build(BuildContext context) =>
      Column(
        children: <Widget>[
          Expanded(child: Image.asset(Assets.tutorialFirstImage)),
          const TutorialText('복잡한 계획은 필요 없어요.\n오늘 할 일을 간단히 추천받고 바로 시작하세요.'),
        ],
      );
}

class TutorialSecondPage extends StatelessWidget {
  const TutorialSecondPage({super.key});

  @override
  Widget build(BuildContext context) =>
      Column(
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
  Widget build(BuildContext context) =>
      const Column(
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
  Widget build(BuildContext context) {
    final double gameHeight = MediaQuery.of(context).size.width / 375 * 300;

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          SizedBox(
            height: gameHeight,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                if (game != null)
                  ClipRRect(
                    child: SizedBox(
                      height: gameHeight,
                      width: double.infinity,
                      child: GameWidget<HorizontalWalkingGame>(game: game!),
                    ),
                  )
                else
                  Image.asset(
                    Assets.gameBackgroundWithoutCloud,
                    width: double.infinity,
                    height: gameHeight,
                    fit: BoxFit.cover,
                  ),
                CloudsOverlay(gameHeight: gameHeight),
              ],
            ),
          ),
          const Spacer(),
          const TutorialText('이제, 당신만의 목표로\n미션을 시작해보세요!'),
        ],
      );
  }
}

class CloudConfig {
  final String asset;
  final double startX;
  final double y;
  final double speed;
  final double size;

  CloudConfig({
    required this.asset,
    required this.startX,
    required this.y,
    required this.speed,
    required this.size,
  });

  double getCurrentPosition(double animationValue, double screenWidth) {
    final double totalDistance = screenWidth + size;
    final double position = startX + (animationValue * totalDistance * speed);
    return position % (screenWidth + size) - size;
  }
}

class CloudsOverlay extends StatefulWidget {
  final double gameHeight;

  const CloudsOverlay({
    required this.gameHeight,
    super.key,
  });

  @override
  State<CloudsOverlay> createState() => _CloudsOverlayState();
}

class _CloudsOverlayState extends State<CloudsOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<CloudConfig> clouds;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    )..repeat();

    initializeClouds();
  }

  void initializeClouds() {
    clouds = <CloudConfig>[
      CloudConfig(
        asset: Assets.tutorialCloud1,
        startX: 150,
        y: widget.gameHeight * 0.2,
        speed: 1.2,
        size: widget.gameHeight * 0.2,
      ),
      // CloudConfig(
      //   asset: Assets.tutorialCloud2,
      //   startX: 100,
      //   y: widget.gameHeight * 0.6,
      //   speed: 0.8,
      //   size: widget.gameHeight * 0.25,
      // ),
      CloudConfig(
        asset: Assets.tutorialCloud3,
        startX: 0,
        y: widget.gameHeight - 37,
        speed: 1.0,
        size: widget.gameHeight * 0.22,
      ),
      CloudConfig(
        asset: Assets.tutorialCloud4,
        startX: 3600,
        y: widget.gameHeight * 0.8,
        speed: 0.9,
        size: widget.gameHeight * 0.18,
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
      children: <Widget>[
        ...clouds.map((CloudConfig cloud) => AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            final double position = cloud.getCurrentPosition(
              _controller.value,
              MediaQuery.of(context).size.width,
            );

            return Positioned(
              left: position,
              top: cloud.y,
              child: SvgPicture.asset(
                cloud.asset,
              ),
              // width: cloud.size,    // 추가
              // height: cloud.size,   // 추가
            );
          },
        )),
      ],
    );
}
