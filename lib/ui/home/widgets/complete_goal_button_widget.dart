import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../widget/mission_complete_dialog.dart';

class CompleteGoalButtonWidget extends StatelessWidget {
  const CompleteGoalButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '목표 기간에 도달했어요!',
            style: LuckitTypos.suitSB12.copyWith(color: LuckitColors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextButton(
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: LuckitColors.white,
                foregroundColor: LuckitColors.main,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 7,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => MissionCompleteDialog(
                    missionTitle: '지극히 평범하게 살기',
                    onComplete: () {},
                  ),
                );
              },
              child: Text(
                '목표 달성',
                style: LuckitTypos.suitSB16.copyWith(color: LuckitColors.main),
              ),
            ),
          ),
        ],
      );
}
