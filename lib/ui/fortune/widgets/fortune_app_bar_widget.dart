import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class FortuneAppBarWidget extends StatelessWidget {
  const FortuneAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            const EdgeInsets.only(top: 52, bottom: 20, left: 24, right: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              '오늘의 운세',
              //TODO(재훈): Typo에 추가
              style: LuckitTypos.suitSB12.copyWith(
                fontSize: 20,
                color: LuckitColors.main,
              ),
            ),
            const SizedBox(width: 16),
            //TODO(재훈): 행간이 이상함
            Text(
              '${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}',
              style: LuckitTypos.suitR14.copyWith(height: 2.0),
            ),
          ],
        ),
      );
}
