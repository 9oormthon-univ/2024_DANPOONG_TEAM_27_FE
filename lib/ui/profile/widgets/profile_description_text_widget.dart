import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class ProfileDescriptionTextWidget extends StatelessWidget {
  const ProfileDescriptionTextWidget({super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16)
          .copyWith(top: 36.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '내가 도전한 목표',
            style: LuckitTypos.suitSB16.copyWith(
              color: LuckitColors.gray80,
            ),
          ),
          Text(
            '48개',
            style: LuckitTypos.suitSB16.copyWith(
              color: LuckitColors.main,
            ),
          ),
        ],
      ),
    );
}
