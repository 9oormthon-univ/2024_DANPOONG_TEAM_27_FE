import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../domain/goal/model/complete_goal_model.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';

class GoFarmWidget extends StatelessWidget {
  final CompleteGoalModel goalModel;

  const GoFarmWidget({
    required this.goalModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: LuckitColors.gray10,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              Assets.goalFilled,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 4),
            Text(
              '${goalModel.startYear}. ${goalModel.startMonth}. ${goalModel.startDay} - ${goalModel.endYear}.${goalModel.endMonth}.${goalModel.endDay}',
              style: LuckitTypos.suitR12.copyWith(color: LuckitColors.gray80),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Text(
                  '농장으로 이동',
                  style:
                      LuckitTypos.suitSB12.copyWith(color: LuckitColors.white),
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
