import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../consts/assets.dart';
import '../../consts/navigation_config.dart';
import 'custom_navigation_bar.dart';
import 'navigation_provider.dart';

class ScaffoldWithNavigation extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  final Widget child;

  const ScaffoldWithNavigation({
    Key? key,
    required this.navigationShell,
    required this.child,
  }) : super(key: key);

  @override
  ConsumerState<ScaffoldWithNavigation> createState() => _ScaffoldWithNavigationState();
}

class _ScaffoldWithNavigationState extends ConsumerState<ScaffoldWithNavigation> {
  void _onTapNavigation(int index) {
    ref.read(navigationProvider.notifier).setIndex(index);
    final hasAlreadyOnBranch = index == widget.navigationShell.currentIndex;

    if (hasAlreadyOnBranch) {
      context.go(NAV_INDEX_ENDPOINT_MAPPER[index]!);
    } else {
      widget.navigationShell.goBranch(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationState = ref.watch(navigationProvider);

    return Scaffold(
      body: widget.child,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomNavigationBar(
        currentIndex: navigationState.currentIndex,
        onTap: _onTapNavigation,
        items: [
          CustomNavigationBarItem(
            icon: Assets.fortuneFilled,
            activeIcon: Assets.fortuneColored,
            label: '운세',
          ),
          CustomNavigationBarItem(
            icon: Assets.homeOutlined,
            activeIcon: Assets.homeColored,
            label: '홈',
          ),
          CustomNavigationBarItem(
            icon: Assets.profileOutlined,
            activeIcon: Assets.profileColored,
            label: 'My',
          ),
        ],
      ),
    );
  }
}