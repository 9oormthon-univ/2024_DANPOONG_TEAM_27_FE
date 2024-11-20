import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../routes/routes.dart';
import '../../theme/luckit_colors.dart';
import '../../theme/luckit_typos.dart';
import '../common/consts/assets.dart';
import '../game/character_data.dart';
import '../game/walking_game.dart';
import 'farm_character_provider.dart';

class FarmView extends ConsumerStatefulWidget {
  const FarmView({super.key});

  @override
  ConsumerState<FarmView> createState() => _FarmViewState();
}

class _FarmViewState extends ConsumerState<FarmView>
    with WidgetsBindingObserver {
  WalkingGame? game;

  @override
  void initState() {
    super.initState();
    initializeGame();
    WidgetsBinding.instance.addObserver(this);
    WakelockPlus.enable();
  }

  void initializeGame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Size screenSize = MediaQuery.of(context).size;

      final List<CharacterData> characters = ref.read(farmCharactersProvider);

      game = WalkingGame(
        boundarySize: Vector2(screenSize.width, screenSize.height),
        characterTypes: characters,
        gameBackground: Assets.farmBackground,
      );
      setState(() {});
    });
  }

  @override
  void didChangeMetrics() {
    if (game == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bool isLandscape =
          MediaQuery.of(context).orientation == Orientation.landscape;
      final String newBackground =
          isLandscape ? Assets.farmBackgroundLandscape : Assets.farmBackground;
      game!.updateBackground(newBackground, isLandscape);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    game?.removeAll(game!.children);
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (game == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GameWidget(game: game!),
          Positioned(
            top: 54,
            left: 0,
            right: 0,
            child: Text(
              'LUCKIT',
              style: LuckitTypos.tenadaEB20
                  .copyWith(color: LuckitColors.background),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Center(
              child: GestureDetector(
                onTap: () => context.go(Routes.home.path),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 4, bottom: 2, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: LuckitColors.background,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: <Widget>[
                      SvgPicture.asset(
                        Assets.homeMainFilled,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        '홈',
                        style: LuckitTypos.suitR12
                            .copyWith(color: LuckitColors.main),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: isLandscape ? 0 : MediaQuery.of(context).size.height * 0.15,
            bottom: isLandscape ? 0 : null,
            child: TimerBuilder.periodic(
              const Duration(seconds: 1),
              builder: (BuildContext context) => Center(
                child: Text(
                  DateFormat('HH:mm').format(DateTime.now()),
                  style: LuckitTypos.tenadaEB20
                      .copyWith(color: LuckitColors.background, fontSize: 100),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
