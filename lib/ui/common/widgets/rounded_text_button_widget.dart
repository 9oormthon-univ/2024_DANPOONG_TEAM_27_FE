import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class RoundedTextButtonWidget extends StatelessWidget {
  final bool isSelected;
  final bool isActivated;
  final String label;
  final VoidCallback onPressed;
  final double height;

  const RoundedTextButtonWidget({
    required this.isSelected,
    required this.label,
    required this.onPressed,
    this.isActivated = true,
    this.height = 40.0,
    super.key,
  });

  Color get backgroundColor => !isActivated
      ? LuckitColors.gray10
      : (isSelected ? LuckitColors.main : LuckitColors.gray10);

  Color get foregroundColor => !isActivated
      ? LuckitColors.gray40
      : (isSelected ? LuckitColors.white : LuckitColors.gray60);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            backgroundColor: backgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: LuckitTypos.suitR20.copyWith(
              height: 0.0,
              color: foregroundColor,
            ),
          ),
        ),
      );
}
