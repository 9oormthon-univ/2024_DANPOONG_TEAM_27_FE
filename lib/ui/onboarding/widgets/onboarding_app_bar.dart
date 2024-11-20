import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/luckit_colors.dart';
import '../../common/consts/assets.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;

  const OnboardingAppBar({
    this.onPressed,
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
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
