// import 'package:go_router/go_router.dart';
// import 'fortune_state.dart';
// import 'fortune_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../routes/routes.dart';
import '../../theme/luckit_colors.dart';
import '../common/widget/bottom_navigation_bar_widget.dart';
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
  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BottomNavigationBarWidget(
          currentRouteName: Routes.fortune.name,
        ),
        backgroundColor: LuckitColors.background,
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FortuneAppBarWidget(),
              IconCardListWidget(),
              SizedBox(height: 24),
              FortuneScoreWidget(),
              SizedBox(height: 24),
              ChipListWidget(),
              SizedBox(height: 12),
              FortuneCardWidget(),
              TimeFortuneGraphListWidget(),
              SizedBox(height: 93),
            ],
          ),
        ),
      );
}
