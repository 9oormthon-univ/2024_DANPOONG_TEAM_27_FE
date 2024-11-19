import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class OnboardingBottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool activated;

  const OnboardingBottomButton({
    required this.onPressed,
    required this.activated,
    super.key,
  });

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: activated ? onPressed : null,
    style: TextButton.styleFrom(
      minimumSize: Size(MediaQuery.of(context).size.width, 64.0),
      backgroundColor: activated ? LuckitColors.main : LuckitColors.gray20,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
    ),
    child: Text(
      '기간 설정하기',
      style: LuckitTypos.suitR20.copyWith(
        color: activated ? LuckitColors.white : LuckitColors.gray80,
      ),
    ),
  );
}
