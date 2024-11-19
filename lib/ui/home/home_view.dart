import 'package:booklog/ui/game/character_provider.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:go_router/go_router.dart';

import '../common/consts/assets.dart';
import '../game/character_data.dart';
import '../game/walking_game.dart';
import '../../routes/app_router.dart';
import '../../routes/routes.dart';
import 'home_state.dart';
import 'home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> with WidgetsBindingObserver{
  WalkingGame? game;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).init();
    });
    initializeGame();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void initializeGame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      final paddingTop = MediaQuery.of(context).padding.top;
      final appBarHeight = AppBar().preferredSize.height;
      final availableHeight = screenSize.height - paddingTop - appBarHeight;
      final gameHeight = availableHeight * 0.3;

      final characters = ref.read(charactersProvider);

      game = WalkingGame(
        boundarySize: Vector2(screenSize.width, gameHeight),
        characterTypes: characters,
      );
      setState(() {});
    });
  }

  @override
  void didChangeMetrics() {
    initializeGame();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    game?.removeAll(game!.children);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);

    //게임 관련
    final characters = ref.watch(charactersProvider);
    final screenSize = MediaQuery.of(context).size;
    final paddingTop = MediaQuery.of(context).padding.top;
    final appBarHeight = AppBar().preferredSize.height;
    final availableHeight = screenSize.height - paddingTop - appBarHeight;
    final gameHeight = availableHeight * 0.3;

    if (game == null) return const Center(child: CircularProgressIndicator());


    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            width: screenSize.width,
            height: gameHeight,
            child: ClipRect(
              child: GameWidget(game: game!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  '현재 캐릭터 수: ${characters.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(charactersProvider.notifier).addCharacter(
                      CharacterData(
                        idleAnimation: Assets.dogStop,
                        walkAnimation: Assets.dogMove,
                        name: '개',
                      ),
                    );
                    initializeGame();
                  },
                  child: const Text('새 캐릭터 추가'),
                ),
                const SizedBox(height: 8),
                if (characters.isNotEmpty)
                  ElevatedButton(
                    onPressed: () {
                      ref.read(charactersProvider.notifier)
                          .removeCharacter(characters.length - 1);
                      initializeGame();
                    },
                    child: const Text('마지막 캐릭터 제거'),
                  ),
              ],
            ),
          ),
          Text(state.example),
          TextButton(
            onPressed: viewModel.onToggleExample,
            child: const Text('toggleExample'),
          ),
          TextButton(
            onPressed: () => context.go(Routes.goal.path),
            child: Text("온보딩"),
          ),
        ],
      ),
    );
  }
}
