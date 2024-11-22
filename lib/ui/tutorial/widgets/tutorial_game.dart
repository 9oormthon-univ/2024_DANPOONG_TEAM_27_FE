import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

import '../../common/consts/assets.dart';

class TutorialGame extends StatefulWidget {
  final String? backgroundImage;
  final Color backgroundColor;
  final double speed;
  final double characterGap;

  const TutorialGame({
    super.key,
    this.backgroundImage,
    this.backgroundColor = Colors.transparent,
    this.speed = 0.5,
    this.characterGap = 200,
  });

  @override
  State<TutorialGame> createState() => _TutorialGameState();
}

class _TutorialGameState extends State<TutorialGame>
    with TickerProviderStateMixin {
  static const List<TutorialGameCharacter> characters = <TutorialGameCharacter>[
    TutorialGameCharacter(name: '쥐', animation: Assets.mouseMove, yOffset: 50),
    TutorialGameCharacter(name: '소', animation: Assets.cowMove, yOffset: 50),
    TutorialGameCharacter(name: '호랑이', animation: Assets.tigerMove, yOffset: 50),
    TutorialGameCharacter(name: '토끼', animation: Assets.rabbitMove),
    TutorialGameCharacter(name: '용', animation: Assets.dragonMove),
    TutorialGameCharacter(name: '뱀', animation: Assets.snakeMove, yOffset: 45),
    TutorialGameCharacter(name: '말', animation: Assets.horseMove),
    TutorialGameCharacter(name: '양', animation: Assets.sheepMove, yOffset: 45),
    TutorialGameCharacter(name: '원숭이', animation: Assets.monkeyMove, yOffset: 45),
    TutorialGameCharacter(name: '꼬꼬', animation: Assets.chickenMove),
    TutorialGameCharacter(name: '개', animation: Assets.dogMove, yOffset: 50),
    TutorialGameCharacter(name: '돼지', animation: Assets.pigMove, yOffset: 50),
  ];

  List<double> xPositions = <double>[];
  late final Ticker _ticker;
  Duration? _lastTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double screenWidth = MediaQuery.of(context).size.width;
      setState(() {
        xPositions = List.generate(
            24,
            (int index) =>
                screenWidth + (index * widget.characterGap) // 화면 바로 오른쪽부터 시작
            );
      });
    });

    _ticker = createTicker((Duration elapsed) {
      if (_lastTime == null) {
        _lastTime = elapsed;
        return;
      }

      final Duration deltaTime = elapsed - _lastTime!;
      _lastTime = elapsed;

      setState(() {
        for (int i = 0; i < xPositions.length; i++) {
          xPositions[i] -= widget.speed * deltaTime.inMilliseconds;
        }
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (xPositions.isEmpty) {
            xPositions = List.generate(
              24,
              (int index) =>
                  constraints.maxWidth + (index * widget.characterGap),
            );
          }

          return Stack(
            children: <Widget>[
              if (widget.backgroundImage != null ||
                  widget.backgroundColor != Colors.transparent)
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  color: widget.backgroundColor,
                  child: widget.backgroundImage != null
                      ? Image.asset(
                          widget.backgroundImage!,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ...List.generate(24, (int index) {
                final TutorialGameCharacter character = characters[index % 12];
                return Positioned(
                  left: xPositions[index],
                  top: (constraints.maxHeight / 2) -
                      (character.size / 2) +
                      character.yOffset,
                  child: SizedBox(
                    width: character.size,
                    height: character.size,
                    child: Lottie.asset(
                      character.animation,
                      repeat: true,
                      animate: true,
                    ),
                  ),
                );
              }),
            ],
          );
        },
      );
}

class TutorialGameCharacter {
  final String name;
  final String animation;
  final double yOffset;
  final double size;

  const TutorialGameCharacter({
    required this.name,
    required this.animation,
    this.yOffset = 40.0,
    this.size = 80.0,
  });
}
