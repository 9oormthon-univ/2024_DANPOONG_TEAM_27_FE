import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';

class AnimatedCard extends StatelessWidget {
  final String title;
  final String comment;
  final String iconPath;
  final String imagePath;

  const AnimatedCard({
    required this.title,
    required this.comment,
    required this.iconPath,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
        decoration: BoxDecoration(
          color: LuckitColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 10,
              color: LuckitColors.shadow2.withOpacity(0.15),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                title,
                style: LuckitTypos.suitSB16,
              ),
            ),
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  iconPath,
                  colorFilter: const ColorFilter.mode(
                    LuckitColors.main,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  comment,
                  style: LuckitTypos.suitR12,
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 130,
                    height: 115,
                    // color: Colors.amber,
                    child: Image.asset(imagePath),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 21.33),
                    width: 53,
                    height: 53,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: LuckitColors.gray20,
                    ),
                    child: SvgPicture.asset(
                      Assets.done,
                      colorFilter: const ColorFilter.mode(
                        LuckitColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
