import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class BottomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool activated;
  final String label;

  const BottomButtonWidget({
    required this.onPressed,
    required this.activated,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) => TextButton(
      onPressed: activated ? onPressed : null,
      style: TextButton.styleFrom(
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
