import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../common/consts/assets.dart';

class CheckIconWidget extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onPressed;
  final double size;

  const CheckIconWidget({
    required this.isChecked,
    required this.onPressed,
    this.size = 32.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: Container(
          constraints: BoxConstraints(  // 이 부분 추가
            minHeight: size,
            minWidth: size,
            maxHeight: size,
            maxWidth: size,
          ),
          // margin: const EdgeInsets.all(2.67),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isChecked ? LuckitColors.main : LuckitColors.gray20,
          ),
          child: Center(
            child: SvgPicture.asset(
              Assets.done,
              width: size,
              height: size,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      );
}
