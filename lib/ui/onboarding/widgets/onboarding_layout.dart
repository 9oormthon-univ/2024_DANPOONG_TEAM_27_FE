import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../common/consts/assets.dart';

class OnboardingLayout extends StatelessWidget {
  final VoidCallback onPressedBackButton;
  final Widget topWidget;
  final Widget content;
  final Widget bottomButton;

  const OnboardingLayout({
    required this.onPressedBackButton,
    required this.topWidget,
    required this.content,
    required this.bottomButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: LuckitColors.background,
    appBar: AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: LuckitColors.white,
      leading: IconButton(
        onPressed: onPressedBackButton,
        icon: SvgPicture.asset(
          Assets.arrowLeft,
        ),
      ),
    ),
    body: Column(
      children: <Widget>[topWidget, content, bottomButton],
    ),
  );
}