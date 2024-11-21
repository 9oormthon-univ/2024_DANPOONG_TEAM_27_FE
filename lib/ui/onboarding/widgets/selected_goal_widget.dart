import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/widgets/rounded_grey_text_widget.dart';

class SelectedGoalWidget extends StatelessWidget {
  final String goal;
  final String duration;

  const SelectedGoalWidget(
      {required this.goal, required this.duration, super.key});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: LuckitColors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: LuckitColors.shadow2.withOpacity(0.15),
              blurRadius: 10.0,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 12.0,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                goal,
                style: LuckitTypos.suitR16.copyWith(
                  color: LuckitColors.main,
                ),
              ),
            ),
            if (duration.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: RoundedGreyTextWidget(label: '추천 기간 $duration'),
              ),
          ],
        ),
      );
}
