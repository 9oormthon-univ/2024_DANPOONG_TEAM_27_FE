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
import '../game/character_provider.dart';
import '../game/walking_game.dart';

import 'home_state.dart';
import 'home_view_model.dart';

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
      final double gameHeight = availableHeight * 0.3;

      final List<CharacterData> characters = ref.read(charactersProvider);

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
    final PageController cardCarouselController =
        PageController(viewportFraction: 300 / 375);
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);

    //게임 관련
    final List<CharacterData> characters = ref.watch(charactersProvider);
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

    return SafeArea(
      child: Scaffold(
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
                      image: DecorationImage(
                        image: AssetImage(Assets.gameBackground),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    width: screenSize.width,
                    height: gameHeight,
                    child: Center(
                      child: TextButton(
                        onPressed: () => context.goNamed(Routes.goal.path),
                        child: const Text('온보딩'),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(
                          23,
                          8,
                          16,
                          10,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 15,
                              color: const Color(0xFF2F56A5).withOpacity(0.15),
                            )
                          ],
                          borderRadius: BorderRadius.circular(16),
                          color: LuckitColors.white.withOpacity(0.1),
                        ),
                        height: 65,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '2024.11.15 - 2024.12.15',
                                  style: LuckitTypos.suitR12.copyWith(
                                    color: LuckitColors.gray20,
                                  ),
                                ),
                                SvgPicture.asset(
                                  width: 20,
                                  height: 20,
                                  Assets.verticalDots,
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '한 달 안에 긍정적인 사람 되어보기',
                                  style: LuckitTypos.suitSB12.copyWith(
                                    color: LuckitColors.gray20,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '완료한 미션 수',
                                      style: LuckitTypos.suitR12.copyWith(
                                        color: LuckitColors.gray20,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '1개',
                                      style: LuckitTypos.suitSB12.copyWith(
                                        color: LuckitColors.gray20,
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
                        FortuneScoreWidget(
                          title: '총운',
                          score: 76,
                        ),
                        FortuneScoreWidget(
                          title: '애정운',
                          score: 70,
                        ),
                        FortuneScoreWidget(
                          title: '금전운',
                          score: 88,
                        ),
                        FortuneScoreWidget(
                          title: '직장운',
                          score: 79,
                        ),
                        FortuneScoreWidget(
                          title: '학업운',
                          score: 80,
                        ),
                        FortuneScoreWidget(
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
                padding: const EdgeInsets.only(left: 25, right: 19),
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
                    GestureDetector(
                      child: SvgPicture.asset(
                        Assets.add,
                        colorFilter: const ColorFilter.mode(
                          LuckitColors.main,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // SizedBox(
              //   width: screenSize.width,
              //   height: gameHeight,
              //   child: ClipRect(
              //     child: GameWidget<WalkingGame>(game: game!),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Column(
              //     children: <Widget>[
              //       Text(
              //         '현재 캐릭터 수: ${characters.length}',
              //         style: const TextStyle(
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const SizedBox(height: 16),
              //       ElevatedButton(
              //         onPressed: () {
              //           ref.read(charactersProvider.notifier).addCharacter(
              //                 CharacterData(
              //                   idleAnimation: Assets.dogStop,
              //                   walkAnimation: Assets.dogMove,
              //                   name: '개',
              //                 ),
              //               );
              //           initializeGame();
              //         },
              //         child: const Text('새 캐릭터 추가'),
              //       ),
              //       const SizedBox(height: 8),
              //       if (characters.isNotEmpty)
              //         ElevatedButton(
              //           onPressed: () {
              //             ref
              //                 .read(charactersProvider.notifier)
              //                 .removeCharacter(characters.length - 1);
              //             initializeGame();
              //           },
              //           child: const Text('마지막 캐릭터 제거'),
              //         ),
              //     ],
              //   ),
              // ),

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
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedCard extends StatelessWidget {
  final String title;
  final String comment;

  const AnimatedCard({
    required this.title,
    required this.comment,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
        decoration: BoxDecoration(
          color: LuckitColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 10,
              color: LuckitColors.shadow2.withOpacity(0.15),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                title,
                style: LuckitTypos.suitSB16,
              ),
            ),
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  Assets.pigOutlined,
                  colorFilter: const ColorFilter.mode(
                    LuckitColors.main,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  comment,
                  style: LuckitTypos.suitR12,
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 130,
                    height: 115,
                    color: Colors.amber,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 21.33),
                    width: 53,
                    height: 53,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: LuckitColors.gray20,
                    ),
                    child: SvgPicture.asset(
                      Assets.done,
                      colorFilter: const ColorFilter.mode(
                        LuckitColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}

class FortuneScoreWidget extends StatelessWidget {
  const FortuneScoreWidget({
    required this.score,
    required this.title,
    super.key,
  });

  final String title;
  final int score;

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Text(
            title,
            style: LuckitTypos.suitR12.copyWith(
              color: LuckitColors.gray80,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$score',
            style: LuckitTypos.suitSB12.copyWith(
              color: LuckitColors.main,
            ),
          ),
        ],
      );
}
