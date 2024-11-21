import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../decoration/profile_box_decoration.dart';

class ProfileGraphWidget extends StatelessWidget {
  const ProfileGraphWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
      margin: const EdgeInsets.only(top: 36.0),
      decoration: profileBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12.0),
            child: Text(
              '목표 달성 그래프',
              style: LuckitTypos.suitSB16
                  .copyWith(color: LuckitColors.gray80),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 20.0),
            child: Text(
              '달성한 미션',
              style: LuckitTypos.suitR12
                  .copyWith(color: LuckitColors.main),
            ),
          ),
          Container(
            margin:
            const EdgeInsets.symmetric(horizontal: 28.0, vertical: 6.0),
            color: LuckitColors.main.withOpacity(0.2),
            height: 100.0,
          ),
        ],
      ),
    );
}
