import 'package:flutter/material.dart';

import '../../../theme/luckit_typos.dart';

class OnboardingDescriptionTextWidget extends StatelessWidget {
  final String text;
  final double topPadding;

  const OnboardingDescriptionTextWidget({
    required this.text,
    required this.topPadding,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      left: 4.0,
      bottom: 10.0,
      top: topPadding,
    ),
    child: Text(
      text,
      style: LuckitTypos.suitR16,
    ),
  );
}