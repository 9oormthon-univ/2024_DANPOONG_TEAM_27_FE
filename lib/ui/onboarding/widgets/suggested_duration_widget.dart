import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class SuggestedDurationWidget extends StatelessWidget {
  final bool isChecked;
  final String duration;

  const SuggestedDurationWidget({
    required this.isChecked,
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: LuckitColors.gray10,
      ),
      child: Text(
        '추천 기간 $duration',
        style: LuckitTypos.suitR10.copyWith(
          color: isChecked ? LuckitColors.gray60 : LuckitColors.gray40,
        ),
      ),
    );
}
