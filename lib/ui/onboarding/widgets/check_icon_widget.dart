import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../common/consts/assets.dart';

class CheckIconWidget extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onPressed;

  const CheckIconWidget(
      {required this.isChecked, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    icon: Container(
      // margin: const EdgeInsets.all(2.67),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isChecked ? LuckitColors.main : LuckitColors.gray20,
      ),
      child: Center(
        child: SvgPicture.asset(
          Assets.done,
          width: 32,
          height: 32,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
  );
}
