import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class FortuneScoreTextWidget extends StatelessWidget {
  const FortuneScoreTextWidget({
    required this.score,
    required this.title,
    super.key,
  });

  final String title;
  final int score;

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Text(
            title,
            style: LuckitTypos.suitR12.copyWith(
              color: LuckitColors.gray80,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$score',
            style: LuckitTypos.suitSB12.copyWith(
              color: LuckitColors.main,
            ),
          ),
        ],
      );
}
