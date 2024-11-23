import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';

class MissionCompleteContainer extends StatelessWidget {
  // final int goalId;

  const MissionCompleteContainer({
    // required this.goalId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LuckitColors.main.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.fromLTRB(4, 12, 8, 12),
      child: Row(
        children: [
          SvgPicture.asset(Assets.goalFilled),
          SizedBox(
            width: 4,
          ),
          Text(
            '목표 기간에 도달했어요!',
            style: LuckitTypos.suitSB16.copyWith(color: Color(0xFF2F56A5)),
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
                '목표 달성',
                style: LuckitTypos.suitSB16.copyWith(color: LuckitColors.main),
              ),
              decoration: BoxDecoration(
                color: LuckitColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
