import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';

class OnboardingDurationNoticeWidget extends StatelessWidget {
  const OnboardingDurationNoticeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
    child: Row(
      children: <Widget>[
        SvgPicture.asset(Assets.warning),
        const SizedBox(width: 4.0),
        Text(
          '목표는 최소 14일 이상 설정해야 해요.',
          style: LuckitTypos.suitR12.copyWith(
            color: LuckitColors.error,
            height: 0.0,
          ),
        ),
      ],
    ),
  );
}
