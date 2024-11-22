import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../routes/routes.dart';
import '../../theme/luckit_colors.dart';
import '../common/consts/assets.dart';
import '../game/character_data.dart';
import '../game/horizontal_walking_game.dart';
import '../game/mission_character_provider.dart';
import '../onboarding/widgets/onboarding_bottom_button.dart';
import 'tutorial_state.dart';
import 'tutorial_view_model.dart';
import 'widgets/tutorial_pages.dart';

class TutorialView extends ConsumerStatefulWidget {
  const TutorialView({super.key});

  @override
  ConsumerState<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends ConsumerState<TutorialView>
    with WidgetsBindingObserver {
  late PageController _controller;
  late double gameHeight;

  HorizontalWalkingGame? game;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    initializeGame();
    WidgetsBinding.instance.addObserver(this);
  }

  void initializeGame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Size screenSize = MediaQuery.of(context).size;
      gameHeight = screenSize.width / 375 * 300;

      final List<CharacterData> characters =
          ref.read(missionCharactersProvider);

      game = HorizontalWalkingGame(
        boundarySize: Vector2(screenSize.width, gameHeight),
        characterTypes: characters,
        gameBackground: Assets.gameBackgroundWithoutCloud,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    final TutorialState state = ref.watch(tutorialViewModelProvider);
    final TutorialViewModel viewModel =
        ref.read(tutorialViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: LuckitColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: LuckitColors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset(Assets.arrowLeft),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => context.goNamed(Routes.home.name),
            icon: SvgPicture.asset(
              Assets.closeMD,
              colorFilter: const ColorFilter.mode(
                LuckitColors.gray80,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: height < 650 ? 40 : 50.0,
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.7,
                child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (int index) =>
                        viewModel.activateButton(index: index),
                    itemCount: pages.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == pages.length - 1) {
                        return TutorialFourthPage(game: game);
                      }
                      return pages[index];
                    }),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: pages.length,
                effect: const ExpandingDotsEffect(
                  dotColor: LuckitColors.gray20,
                  activeDotColor: LuckitColors.main,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 2,
                  spacing: 4,
                ),
              ),
              const Expanded(child: SizedBox()),
              OnboardingBottomButton(
                onPressed: () => context.goNamed('/home'),
                activated: state.activated,
                label: '시작하기',
                height: height < 650 ? 52 : 64,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<StatelessWidget> pages = <StatelessWidget>[
  const TutorialFirstPage(),
  const TutorialSecondPage(),
  const TutorialThirdPage(),
  const TutorialFourthPage(game: null),
];
