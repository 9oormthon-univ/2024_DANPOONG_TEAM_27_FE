import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class FortuneScoreWidget extends StatelessWidget {
  const FortuneScoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.5, vertical: 2),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(width: 6.5),
                const Text(
                  '총운 지수',
                  style: LuckitTypos.suitR12,
                ),
                const SizedBox(width: 8),
                Text(
                  '80',
                  style:
                      LuckitTypos.suitSB16.copyWith(color: LuckitColors.main),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: LuckitColors.gray10,
                        ),
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: <Color>[
                                LuckitColors.gradient1Stop42,
                                LuckitColors.gradient1Stop100.withOpacity(0.7),
                              ]),
                        ),
                        width: 260,
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
