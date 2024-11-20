import '../game/mission_character_provider.dart';
import 'package:flame/components.dart';

import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../routes/routes.dart';
import '../../theme/luckit_colors.dart';
import '../../theme/luckit_typos.dart';
import '../common/consts/assets.dart';
import '../common/widget/bottom_navigation_bar_widget.dart';
import '../game/character_data.dart';
import '../game/mission_character_provider.dart';
import '../game/walking_game.dart';
import 'home_state.dart';
import 'home_view_model.dart';
import 'widgets/animated_card_widget.dart';
import 'widgets/complete_goal_button_widget.dart';
import 'widgets/fortune_score_text_widet.dart';
import 'widgets/goal_status_bar_widget.dart';

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
      final double gameHeight = screenSize.width / 375 * 300;
      // availableHeight * 0.3;

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

    // 추천 미션 캐러셀 슬라이드 페이지 컨트롤러
    final PageController cardCarouselController =
        PageController(viewportFraction: 300 / 375);

    //게임 관련

    final List<CharacterData> characters = ref.watch(missionCharactersProvider);
    final Size screenSize = MediaQuery.of(context).size;
    final double gameHeight = screenSize.width / 375 * 300;
    // final double paddingTop = MediaQuery.of(context).padding.top;
    // final double appBarHeight = AppBar().preferredSize.height;
    // final double availableHeight =
    //     screenSize.height - paddingTop - appBarHeight;
    // final double gameHeight = availableHeight * 0.3;

    if (game == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        currentRouteName: Routes.home.name,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                // 게임 컨테이너
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                    // color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage(Assets.gameBackgroundAsset),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  width: screenSize.width,
                  height: gameHeight,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        // Container와 동일한 borderRadius 적용
                        bottom: Radius.circular(16),
                      ),
                      child: GameWidget<WalkingGame>(game: game!)),
                  // Center(
                  //   child: TextButton(
                  //     onPressed: () => context.goNamed(Routes.goal.path),
                  //     child: const Text('온보딩'),
                  //   ),
                  // ),
                ),
                // 게임 캐릭터 추가, 삭제 예시 코드
                // ElevatedButton(
                //   onPressed: () {
                //     final newCharacter = CharacterData(
                //       idleAnimation: Assets.dogStop,
                //       walkAnimation: Assets.dogMove,
                //       name: '개',
                //     );
                //     ref
                //         .read(missionCharactersProvider.notifier)
                //         .addCharacter(newCharacter);
                //     game?.addCharacter(newCharacter);
                //   },
                //   child: const Text('새 캐릭터 추가'),
                // ),
                // if (characters.isNotEmpty)
                //   ElevatedButton(
                //     onPressed: () {
                //       final index = characters.length - 1;
                //       final characterToRemove = characters[index];
                //       ref
                //           .read(missionCharactersProvider.notifier)
                //           .removeCharacter(index);
                //       game?.removeCharacterByName(characterToRemove.name);
                //     //game?.removeCharacterByName('개');
                //     },
                //     child: const Text('마지막 캐릭터 제거'),
                //   ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    CompleteGoalButtonWidget(),
                    SizedBox(height: 8),
                    GoalStatusBarWidget(),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: state.isGoalButtonOpen,
                    maintainState: true,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        bottom: 67,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 8,
                            color: LuckitColors.shadow1.withOpacity(0.15),
                          )
                        ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: IconButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(
                                    LuckitColors.white,
                                  ),
                                  elevation: WidgetStatePropertyAll<double>(
                                    10,
                                  ),
                                ),
                                icon: SvgPicture.asset(
                                  Assets.edit,
                                  colorFilter: const ColorFilter.mode(
                                    LuckitColors.main,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                onPressed: () {
                                  viewModel
                                    ..toggleGoalButtons(isCurrentOpen: true)
                                    ..toggleGoalEdit(isCurrentEditing: false);
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: IconButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(
                                    LuckitColors.white,
                                  ),
                                ),
                                icon: SvgPicture.asset(
                                  Assets.delete,
                                  colorFilter: const ColorFilter.mode(
                                    LuckitColors.error,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                onPressed: () {
                                  print('목표 삭제');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.fortuneColored,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    '오늘의 운세 기반 추천 미션',
                    style: LuckitTypos.suitSB16,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 11),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 0.5, bottom: 8),
                    child: Text('오늘의 운세지수'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FortuneScoreTextWidget(
                        title: '총운',
                        score: 76,
                      ),
                      FortuneScoreTextWidget(
                        title: '애정운',
                        score: 70,
                      ),
                      FortuneScoreTextWidget(
                        title: '금전운',
                        score: 88,
                      ),
                      FortuneScoreTextWidget(
                        title: '직장운',
                        score: 79,
                      ),
                      FortuneScoreTextWidget(
                        title: '학업운',
                        score: 80,
                      ),
                      FortuneScoreTextWidget(
                        title: '건강운',
                        score: 91,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 9),
            SizedBox(
              width: screenSize.width,
              height: 200,
              child: PageView.builder(
                controller: cardCarouselController, // 카드 크기 조정
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) =>
                    const AnimatedCard(
                  title: '오늘의 기분 좋은 일 하나 적기',
                  comment: '금전운을 향상시킬 수 있어요',
                ),
              ),
            ),
            const SizedBox(height: 16),
            SmoothPageIndicator(
              controller: cardCarouselController,
              count: 3,
              effect: const ExpandingDotsEffect(
                dotColor: LuckitColors.gray20,
                activeDotColor: LuckitColors.main,
                dotHeight: 4,
                dotWidth: 4,
                expansionFactor: 2,
                spacing: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 38, bottom: 14),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.fortuneColored,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    '내가 만든 미션',
                    style: LuckitTypos.suitSB16,
                  ),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    style: const ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    icon: SvgPicture.asset(
                      Assets.add,
                      colorFilter: const ColorFilter.mode(
                        LuckitColors.main,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: LuckitColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: LuckitColors.shadow2.withOpacity(0.15),
                    blurRadius: 10,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Column(
                children: <Widget>[
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => Row(
                      children: <Widget>[
                        Expanded(
                          child: Material(
                            color: LuckitColors.transparent,
                            child: InkWell(
                              splashFactory: InkRipple.splashFactory,
                              onLongPress: () {},
                              child: const Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 9),
                                      child: Text('data'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          margin: const EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                            color: LuckitColors.gray20,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: SvgPicture.asset(
                            Assets.done,
                            colorFilter: const ColorFilter.mode(
                                LuckitColors.white, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: LuckitColors.gray20,
                    ),
                    itemCount: 3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
