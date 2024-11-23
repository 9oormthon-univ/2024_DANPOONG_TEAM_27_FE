// import 'package:go_router/go_router.dart';
// import 'fortune_state.dart';
// import 'fortune_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../core/loading_status.dart';
import '../../domain/fortune/model/fortune_model.dart';
import '../../routes/routes.dart';
import '../../theme/luckit_colors.dart';
import '../common/consts/assets.dart';
import '../common/widget/bottom_navigation_bar_widget.dart';
import 'fortune_state.dart';
import 'fortune_view_model.dart';
import 'widgets/chip_list_widget.dart';
import 'widgets/fortune_app_bar_widget.dart';
import 'widgets/fortune_card_widget.dart';
import 'widgets/fortune_score_widget.dart';
import 'widgets/icon_card_widget.dart';
import 'widgets/time_fortune_graph_list_widget.dart';

class FortuneView extends ConsumerStatefulWidget {
  const FortuneView({super.key});

  @override
  ConsumerState<FortuneView> createState() => _FortuneViewState();
}

class _FortuneViewState extends ConsumerState<FortuneView> {
  String _getScoreByCategory(
      String category, List<CategoryFortuneScores> scores) {
    final score = scores.firstWhere(
      (score) => score.category == category,
      orElse: () => CategoryFortuneScores(category: category, score: 0),
    );
    return score.score.toString();
  }

  int _getScoreByTitle(String title, FortuneState state) {
    if (state.fortune == null) return 0;

    final Map<String, String> titleToCategory = {
      '총운': 'all_luck',
      '애정운': 'Love',
      '금전운': 'Money',
      '직장운': 'Work',
      '학업운': 'Study',
      '건강운': 'Health',
    };

    final category = titleToCategory[title];
    if (category == null) return 0;

    final score = state.fortune!.categoryFortuneScores.firstWhere(
      (score) => score.category == category,
      orElse: () => CategoryFortuneScores(category: category, score: 0),
    );

    return score.score;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(fortuneViewModelProvider.notifier).getFortune();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final FortuneState state = ref.watch(fortuneViewModelProvider);
    // final FortuneViewModel viewModel = ref.watch(fortuneViewModelProvider.notifier);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        currentRouteName: Routes.fortune.name,
      ),
      backgroundColor: LuckitColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const FortuneAppBarWidget(),
            const IconCardListWidget(),
            const SizedBox(height: 24),
            if (state.loadingStatus == LoadingStatus.loading)
              Center(
                child: Transform.scale(
                  scale: 0.7,
                  child: Lottie.asset(Assets.loading),
                ),
              ),
            if (state.loadingStatus == LoadingStatus.success)
              FortuneScoreWidget(
                title: state.selectedTitle,
                score: _getScoreByTitle(state.selectedTitle, state),
              ),
            if (state.loadingStatus == LoadingStatus.success)
              const SizedBox(height: 24),
            if (state.loadingStatus == LoadingStatus.success)
              ChipListWidget(
                  titles: state.fortune?.fortuneKeywords ?? <String>[]),
            if (state.loadingStatus == LoadingStatus.success)
              const SizedBox(height: 12),
            if (state.loadingStatus == LoadingStatus.success)
              FortuneCardWidget(
                shortFortune: state.fortune?.shortFortune ?? '',
                fullFortune: state.fortune?.fullFortune ?? '',
              ),
            if (state.loadingStatus == LoadingStatus.success)
              TimeFortuneGraphListWidget(
                timeOfDayFortuneScores: state.fortune?.timeOfDayFortuneScores ??
                    <TimeOfDayFortuneScores>[],
              ),
            const SizedBox(height: 93),
          ],
        ),
      ),
    );
  }
}
