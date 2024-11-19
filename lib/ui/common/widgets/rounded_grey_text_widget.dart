import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class RoundedGreyTextWidget extends StatelessWidget {
  final String label;
  final bool activated;

  const RoundedGreyTextWidget({
    required this.label,
    this.activated = true,
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
        label,
        style: LuckitTypos.suitR10.copyWith(
          color: activated ? LuckitColors.gray60 : LuckitColors.gray40,
        ),
      ),
    );
}
