import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class LandscapeCharacterBox extends StatelessWidget {
  final String number;
  final String frame;

  const LandscapeCharacterBox({
    required this.number,
    required this.frame,
    super.key,
  });

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: LuckitColors.gray10,)),
    child: Stack(
      children: <Widget>[
        Positioned(
          top: 10,
          child: Text(
            number,
            style: LuckitTypos.suitSB20.copyWith(
              color: LuckitColors.gray80,
              height: 1.6,
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          bottom: 1,
          child: SvgPicture.asset(frame),
        ),
      ],
    ),
  );
}
