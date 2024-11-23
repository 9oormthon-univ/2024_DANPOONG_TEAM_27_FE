import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../../common/widgets/rounded_grey_text_widget.dart';
import '../../onboarding/onboarding_state.dart';

class ProfileInfoWidget extends StatelessWidget {
  final String year;
  final String month;
  final String day;
  final String hour;
  final String minute;
  final bool unknownTime;
  final GenderType gender;
  final String name;

  const ProfileInfoWidget({
    required this.year,
    required this.month,
    required this.day,
    required this.unknownTime,
    required this.gender,
    required this.hour,
    required this.minute,
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          const SizedBox(width: 24.0),
          Text(
            name,
            style: LuckitTypos.suitR20.copyWith(
              color: LuckitColors.main,
              height: 0.0,
            ),
          ),
          const SizedBox(width: 16.0),
          RoundedGreyTextWidget(label: '$year.$month.$day'),
          const SizedBox(width: 8.0),
          if (!unknownTime) RoundedGreyTextWidget(label: '$hour:$minute 생'),
          const SizedBox(width: 8.0),
          RoundedGreyTextWidget(label: gender == GenderType.male ? '남성' : '여성'),
        ],
      );
}
