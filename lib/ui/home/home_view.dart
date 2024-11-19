import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:go_router/go_router.dart';



import '../../routes/app_router.dart';
import '../../routes/routes.dart';
import 'home_state.dart';
import 'home_view_model.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
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

          TextButton(
            onPressed: () => context.go(Routes.goal.path),
            child: Text("온보딩"),
          ),

        ],
      ),
    );
  }
}
