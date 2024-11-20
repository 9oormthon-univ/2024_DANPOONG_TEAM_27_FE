import 'package:booklog/ui/game/mission_character_provider.dart';
import 'package:flame/components.dart';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../routes/routes.dart';
import '../common/consts/assets.dart';
import '../common/widget/bottom_navigation_bar_widget.dart';
import '../game/character_data.dart';
import '../game/walking_game.dart';

import 'home_state.dart';
import 'home_view_model.dart';
import 'widget/add_mission_bottom_sheet.dart';
import 'widget/mission_manage_bottom_sheet.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with WidgetsBindingObserver {
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
      final Size screenSize = MediaQuery.of(context).size;
      final double paddingTop = MediaQuery.of(context).padding.top;
      final double appBarHeight = AppBar().preferredSize.height;
      final double availableHeight =
          screenSize.height - paddingTop - appBarHeight;
      final double gameHeight = availableHeight * 0.3;

      final List<CharacterData> characters =
          ref.read(missionCharactersProvider);

      game = WalkingGame(
        boundarySize: Vector2(screenSize.width, gameHeight),
        characterTypes: characters,
        gameBackground: Assets.gameBackground,
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

    final List<CharacterData> characters = ref.watch(missionCharactersProvider);
    final Size screenSize = MediaQuery.of(context).size;
    final double paddingTop = MediaQuery.of(context).padding.top;
    final double appBarHeight = AppBar().preferredSize.height;
    final double availableHeight =
        screenSize.height - paddingTop - appBarHeight;
    final double gameHeight = availableHeight * 0.3;

    if (game == null) return const Center(child: CircularProgressIndicator());

    // 바텀시트를 호출하는 곳에서
    final TextEditingController _missionController = TextEditingController();

    void _showAddMissionBottomSheet() {
      showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddMissionBottomSheet(
            title: '새로운 미션 추가하기',
            subtitle: '도전할 미션을 작성해보세요!',
            buttonLabel: '추가하기',
          ),
        ),
      ).then((missionText) {
        if (missionText != null) {
          setState(() {
            _missionController.text = missionText; // 입력된 텍스트 저장
          });
        }
      });
    }



    void _showMissionManageBottomSheet() {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => MissionManageBottomSheet(title: '거울 볼 때마다 미소짓기',),
      );
    }

    @override
    void dispose() {
      _missionController.dispose();
      super.dispose();
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        currentRouteName: Routes.home.name,
      ),
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: screenSize.width,
            height: gameHeight,
            child: ClipRect(
              child: GameWidget<WalkingGame>(game: game!),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
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
                    ref.read(missionCharactersProvider.notifier).addCharacter(
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
                      ref
                          .read(missionCharactersProvider.notifier)
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

          /// dot_indicator 예시 코드
          // SmoothPageIndicator(
          //   controller: pageController,
          //   count: _totalDots,
          //   effect: ExpandingDotsEffect(
          //     dotColor: Colors.grey,
          //     activeDotColor: Colors.indigo,
          //     dotHeight: 12,
          //     dotWidth: 12,
          //     expansionFactor: 4,
          //   ),
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => context.go(Routes.goal.path),
                child: const Text('온보딩'),
              ),
              TextButton(
                onPressed: () => context.go(Routes.farm.path),
                child: Text("농장"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => _showAddMissionBottomSheet(),
                child: Text("미션추가 바텀시트"),
              ),
              TextButton(
                onPressed: () => _showMissionManageBottomSheet(),
                child: Text("미션수정 바텀시트"),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
