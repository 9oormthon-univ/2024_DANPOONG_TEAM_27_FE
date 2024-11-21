import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../common/consts/assets.dart';

class GoToFarmButtonWidget extends StatelessWidget {
  const GoToFarmButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => IconButton(
        constraints: const BoxConstraints(),
        style: const ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: WidgetStatePropertyAll<Color>(LuckitColors.white),
          overlayColor: WidgetStatePropertyAll<Color>(LuckitColors.gray10),
        ),
        color: Colors.amber,
        onPressed: () {},
        icon: SvgPicture.asset(Assets.pawColored),
      );
}
