import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class OnboardingBottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool activated;
  final String label;
  final double height;

  const OnboardingBottomButton({
    required this.onPressed,
    required this.activated,
    this.label = '기간 설정하기',
    this.height = 64.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: activated ? onPressed : null,
    style: TextButton.styleFrom(
      minimumSize: Size(MediaQuery.of(context).size.width, height),
      backgroundColor: activated ? LuckitColors.main : LuckitColors.gray20,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
    ),
    child: Text(
      label,
      style: LuckitTypos.suitR20.copyWith(
        color: activated ? LuckitColors.white : LuckitColors.gray80,
        height: 0.0,
      ),
    ),
  );
}
