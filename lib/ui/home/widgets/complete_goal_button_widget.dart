import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class CompleteGoalButtonWidget extends StatelessWidget {
  const CompleteGoalButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        margin: const EdgeInsets.only(
          right: 24,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: LuckitColors.white,
        ),
        child: Text(
          '목표 달성',
          style: LuckitTypos.suitSB12.copyWith(color: LuckitColors.main),
        ),
      );
}
