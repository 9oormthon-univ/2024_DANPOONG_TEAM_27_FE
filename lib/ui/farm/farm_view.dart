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
import '../common/widget/bottom_navigation_bar_widget.dart';
import '../game/character_data.dart';
import '../game/walking_game.dart';
import 'farm_character_provider.dart';
import 'widget/goal_glass.dart';

class FarmView extends ConsumerStatefulWidget {
  const FarmView({super.key});

  @override
  ConsumerState<FarmView> createState() => _FarmViewState();
}

class _FarmViewState extends ConsumerState<FarmView>
    with WidgetsBindingObserver {
  WalkingGame? game;
  bool _animalSelected = false;
  bool _clockSelected = false;

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
    if (game == null) {
      return;
    }

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
            left: 25,
            right: 25,
            child: Column(
              children: [
                Text(
                  'LUCKIT',
                  style: LuckitTypos.tenadaEB20
                      .copyWith(color: LuckitColors.background),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8,
                ),
                Visibility(
                  visible: !_clockSelected,
                  child: GoalGlass(),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 27,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 55),
              padding: const EdgeInsets.symmetric(horizontal: 48),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  BottomNavigationBarItemWidget(
                    label: '동물',
                    selectedAsset: Assets.animalColored,
                    unselectedAsset: Assets.animalFilled,
                    isSelected: _animalSelected,
                    onTap: () {
                      // context.goNamed(Routes.fortune.name);
                    },
                  ),
                  BottomNavigationBarItemWidget(
                    label: '홈',
                    selectedAsset: Assets.homeColored,
                    unselectedAsset: Assets.homeOutlined,
                    isSelected: true,
                    onTap: () {
                      context.goNamed(Routes.home.name);
                    },
                  ),
                  BottomNavigationBarItemWidget(
                    label: '시계',
                    selectedAsset: Assets.clockColored,
                    unselectedAsset: Assets.clockFilled,
                    isSelected: _clockSelected,
                    onTap: () {
                      // context.goNamed(Routes.profile.name);
                    },
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   top: isLandscape ? 0 : MediaQuery.of(context).size.height * 0.15,
          //   bottom: isLandscape ? 0 : null,
          //   child: TimerBuilder.periodic(
          //     const Duration(seconds: 1),
          //     builder: (BuildContext context) => Center(
          //       child: Text(
          //         DateFormat('HH:mm').format(DateTime.now()),
          //         style: LuckitTypos.tenadaEB20
          //             .copyWith(color: LuckitColors.background, fontSize: 100),
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
