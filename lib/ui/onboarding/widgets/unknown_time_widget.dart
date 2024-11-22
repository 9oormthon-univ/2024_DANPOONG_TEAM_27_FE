import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import 'check_icon_widget.dart';

class UnknownTimeWidget extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onPressed;
  final bool leftPadding;

  const UnknownTimeWidget({
    required this.isChecked,
    required this.onPressed,
    required this.leftPadding,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          if (leftPadding) const SizedBox(width: 12),
          CheckIconWidget(
            isChecked: isChecked,
            onPressed: onPressed,
            size: 16.0,
          ),
          Text(
            '태어난 시간을 알지 못합니다',
            style: LuckitTypos.suitR10.copyWith(
              color: LuckitColors.gray80,
              height: 0.0,
            ),
          ),
        ],
      );
}
