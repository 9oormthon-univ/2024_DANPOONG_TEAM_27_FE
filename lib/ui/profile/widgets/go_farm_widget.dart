import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';

class GoFarmWidget extends StatelessWidget {
  const GoFarmWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LuckitColors.gray10,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.fromLTRB(4, 8, 8, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.goalFilled, width: 20, height: 20,),
          SizedBox(
            width: 4,
          ),
          Text(
            '2024. 08. 11 - 2024.10.14',
            style: LuckitTypos.suitR12.copyWith(color: LuckitColors.gray80),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Text(
                '농장으로 이동',
                style: LuckitTypos.suitSB12.copyWith(color: LuckitColors.white),
              ),
              decoration: BoxDecoration(
                color: LuckitColors.main,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
