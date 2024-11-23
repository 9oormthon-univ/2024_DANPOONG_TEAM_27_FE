import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../theme/luckit_colors.dart';
import '../../common/consts/assets.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;
  final PageController? pageController;

  const OnboardingAppBar({
    this.onPressed,
    this.pageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: LuckitColors.white,
        leading: IconButton(
          onPressed: onPressed ?? () => context.pop(),
          icon: SvgPicture.asset(
            Assets.arrowLeft,
          ),
        ),
    actions: pageController != null ? [
      SmoothPageIndicator(
        controller: pageController!,
        count: 4,
        effect: const ExpandingDotsEffect(
          dotColor: LuckitColors.gray20,
          activeDotColor: LuckitColors.main,
          dotHeight: 8,
          dotWidth: 8,
          expansionFactor: 2,
          spacing: 4,
        ),
      ),
      SizedBox(width: 24,),
    ] :null,
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
