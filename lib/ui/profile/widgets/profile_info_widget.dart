import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../../common/widgets/rounded_grey_text_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            '미르미',
            style: LuckitTypos.suitR20.copyWith(
              color: LuckitColors.main,
              height: 0.0,
            ),
          ),
          const SizedBox(width: 16.0),
          const RoundedGreyTextWidget(label: '2000.04.19'),
          const SizedBox(width: 8.0),
          const RoundedGreyTextWidget(label: '07:23 생'),
          const SizedBox(width: 8.0),
          const RoundedGreyTextWidget(label: '여성'),
        ],
      ),
      Material(
        color: LuckitColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {},
          child: SvgPicture.asset(
            Assets.edit,
            colorFilter: const ColorFilter.mode(
              LuckitColors.gray60,
              BlendMode.srcIn,
            ),
          ),
        ),
      )
    ],
  );
}
