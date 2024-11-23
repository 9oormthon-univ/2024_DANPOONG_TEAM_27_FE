import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/loading_status.dart';
import '../../routes/routes.dart';
import '../../service/app/app_service.dart';
import '../../theme/luckit_colors.dart';
import '../../theme/luckit_typos.dart';
import '../common/consts/assets.dart';
import '../common/consts/util.dart';
import '../common/widget/bottom_navigation_bar_widget.dart';
import '../common/widgets/rounded_text_button_widget.dart';
import '../edit/editing_state.dart';
import '../edit/editing_view_model.dart';
import '../game/character_data.dart';
import '../game/mission_character_provider.dart';
import '../game/walking_game.dart';
import 'home_state.dart';
import 'home_view_model.dart';
import 'widget/add_mission_bottom_sheet.dart';
import 'widget/mission_complete_container.dart';
import 'widget/mission_manage_bottom_sheet.dart';
import 'widgets/animated_card_widget.dart';
import 'widgets/complete_goal_button_widget.dart';
import 'widgets/fortune_score_text_widet.dart';
import 'widgets/go_to_farm_button_widget.dart';
import 'widgets/goal_status_bar_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with WidgetsBindingObserver {
  final ScrollController mainAxisScrollController = ScrollController();
  WalkingGame? game;

  @override
  void initState() {
    super.initState();
    initializeGame();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).init();
    });

    WidgetsBinding.instance.addObserver(this);
    mainAxisScrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (mainAxisScrollController.offset <= 0.99) {
      mainAxisScrollController.jumpTo(1);
    }
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
    mainAxisScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);
    ref.listen(
        editingViewModelProvider
            .select((EditingState value) => value.createGoalLoadingStatus),
        (LoadingStatus? prev, LoadingStatus cur) async {
      if (cur == LoadingStatus.success) {
        await viewModel.getCurrentGoal();
        await viewModel.getCurrentTodoList();
        if (context.mounted) {
          context.goNamed(Routes.home.name);
        }
      }
    });

    final AppService appService = ref.read(appServiceProvider.notifier);
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
      floatingActionButton: BottomNavigationBarWidget(
        currentRouteName: Routes.home.name,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        controller: mainAxisScrollController,
        physics: const BouncingScrollPhysics(),
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
                ),
                if (state.isGoalRegistered)
                  const Positioned(
                    right: 24,
                    bottom: 82 + 16,
                    child: GoToFarmButtonWidget(),
                  ),

                // 목표 스테이터스 바
                if (state.isGoalRegistered)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: state.isGoalCompleted
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: <Widget>[
                            if (state.isGoalCompleted)
                              const CompleteGoalButtonWidget()
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const GoalStatusBarWidget(),
                    ],
                  ),

                // 목표 관련 더보기
                Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: state.isGoalButtonOpen,
                    maintainState: true,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        bottom: 85,
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
                                    viewModel
                                      ..toggleGoalButtons(isCurrentOpen: true)
                                      ..deleteGoal();
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: MissionCompleteContainer(),
            ),
            TextButton(
              onPressed: appService.signOut,
              child: const Text('로그아웃'),
            ),
            const SizedBox(height: 16),
            Builder(
              builder: (BuildContext context) {
                if (!state.isGoalRegistered) {
                  return Column(
                    children: <Widget>[
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
                      Container(
                        margin: const EdgeInsets.only(top: 57, bottom: 16),
                        child: Image.asset(Assets.emptyDragon),
                      ),
                      const Text('목표를 등록하면 오늘의'),
                      const Text('맞춤 미션을 추천받을 수 있어요!'),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RoundedTextButtonWidget(
                                height: 52,
                                isSelected: true,
                                label: '목표 등록하기',
                                onPressed: () {
                                  context.goNamed(Routes.editGoal.name);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 110),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
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
                          controller: cardCarouselController,
                          itemCount: state.currentTodoList
                              .where((todo) => todo.isMadeByGpt)
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            final gptTodos = state.currentTodoList
                                .where((todo) => todo.isMadeByGpt)
                                .toList();
                            final todo = gptTodos[index];
                            return AnimatedCard(
                              title: todo.name,
                              comment: fortuneTypeToComment[todo.fortuneType] ??
                                  '운을 향상시킬 수 있어요',  
                              iconPath: Assets.pigOutlined,
                              imagePath: fortuneTypeToAsset[todo.fortuneType] ??
                                  Assets.money,
                            );
                          },
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
                        padding: const EdgeInsets.only(
                            left: 25, right: 38, bottom: 14),
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
                              onPressed: () {
                                showModalBottomSheet<String>(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: const AddMissionBottomSheet(
                                      title: '새로운 미션 추가하기',
                                      subtitle: '도전할 미션을 작성해보세요!',
                                      buttonLabel: '추가하기',
                                      initialText: '',
                                    ),
                                  ),
                                ).then((String? missionText) {
                                  if (missionText != null) {
                                    // 추가 로직
                                  }
                                });
                              },
                              style: const ButtonStyle(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap),
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
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: ListView.separated(
                          padding: const EdgeInsets.only(top: 12),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final todo = state.currentTodoList[index];
                            if (todo.isMadeByGpt) {
                              return const SizedBox.shrink();
                            }
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: Material(
                                    color: LuckitColors.transparent,
                                    child: InkWell(
                                      splashFactory: InkRipple.splashFactory,
                                      onLongPress: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) =>
                                               MissionManageBottomSheet(
                                            title: todo.name,
                                            todoId: todo.todoId,
                                            updateTodo: viewModel.updateTodo,
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 11.5,
                                              ),
                                              child: Text(todo.name),
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
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            color: LuckitColors.gray20,
                            height: 1,
                          ),
                          itemCount: state.currentTodoList.length,
                        ),
                      ),
                      const SizedBox(height: 140),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
