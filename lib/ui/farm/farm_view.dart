import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'widget/animal_glass.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
          GameWidget<WalkingGame>(game: game!),
          Positioned(
            top: !isLandscape ? 54 : 40,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                if (!isLandscape) ...<Widget>[
                  Text(
                    'LUCKIT',
                    style: LuckitTypos.tenadaEB20
                        .copyWith(color: LuckitColors.background),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  opacity: _clockSelected ? 0.0 : 1.0,
                  child: GoalGlass(
                    userName: '수정',
                    startDate: DateTime(2024, 11, 15),
                    endDate: DateTime(2024, 12, 15),
                    goalTitle: '자연스럽게 숨쉬기 농장',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 27,
            child: Center(
              child: Container(
                width: isLandscape
                    ? MediaQuery.of(context).size.height - 110
                    : MediaQuery.of(context).size.width - 110,
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
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      BottomNavigationBarItemWidget(
                        label: '동물',
                        selectedAsset: Assets.animalColored,
                        unselectedAsset: Assets.animalFilled,
                        isSelected: _animalSelected,
                        onTap: () {
                          setState(() {
                            _animalSelected = !_animalSelected;
                          });
                        },
                      ),
                      BottomNavigationBarItemWidget(
                        label: '홈으로',
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
                          setState(() {
                            _clockSelected = !_clockSelected;
                          });
                          // context.goNamed(Routes.profile.name);
                        },
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
            top: isLandscape
                ? MediaQuery.of(context).size.height * 0.07
                : MediaQuery.of(context).size.height * 0.15,
            // bottom: isLandscape ? 0 : null,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              opacity: _clockSelected ? 1.0 : 0.0,
              child: TimerBuilder.periodic(
                const Duration(seconds: 1),
                builder: (BuildContext context) => Center(
                  child: Text(
                    DateFormat('HH:mm').format(DateTime.now()),
                    style: LuckitTypos.tenadaEB20.copyWith(
                        color: LuckitColors.background, fontSize: 100),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: isLandscape ? null : 0,
            right: isLandscape ? 0 : null,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              offset: isLandscape
                  ? Offset(0.0, _animalSelected ? 0.0 : -1.0)
                  : Offset(_animalSelected ? 0.0 : -1.0, 0.0),
              child: const AnimalGlass(),
            ),
          ),
        ],
      ),
    );
  }
}
