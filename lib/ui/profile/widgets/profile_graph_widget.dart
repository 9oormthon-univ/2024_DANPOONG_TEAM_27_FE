import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../data/graph_data.dart';
import '../decoration/profile_box_decoration.dart';
import 'line_chart_widget.dart';

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
              padding: const EdgeInsets.only(left: 16.0, top: 12.0, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '목표 달성 그래프',
                    style: LuckitTypos.suitSB16
                        .copyWith(color: LuckitColors.gray80),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '2024년 11월',
                        textAlign: TextAlign.right,
                        style: LuckitTypos.suitR12
                            .copyWith(color: LuckitColors.gray60),
                      ),
                      CustomIconButton(
                        iconPath: Assets.arrowLeft,
                        onTap: () {},
                      ),
                      CustomIconButton(
                        iconPath: Assets.arrowRight,
                        onTap: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 20.0),
              child: Text(
                '달성한 미션',
                style: LuckitTypos.suitR12.copyWith(color: LuckitColors.main),
              ),
            ),
            Stack(
              children: <Widget>[
                const Positioned(
                  left: 28.0,
                  bottom: 10.0,
                  child: DottedLine(
                    direction: Axis.vertical,
                    dashColor: LuckitColors.main,
                    lineLength: 94.0,
                  ),
                ),
                Positioned(
                  left: 28.0,
                  bottom: 10.0,
                  child: DottedLine(
                    dashColor: LuckitColors.main,
                    lineLength: MediaQuery.of(context).size.width - 100,
                  ),
                ),
                Positioned(
                  right: 16.0,
                  bottom: 4.0,
                  child: Text(
                    '일',
                    style: LuckitTypos.suitR12.copyWith(
                      color: LuckitColors.main,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 6.0,
                  ),
                  height: 94.0,
                  child: LineChartWidget(spots: spots),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28.0,
                right: 28.0,
                bottom: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (int i = 0; i <= 6; i++)
                    Text(
                      i == 0 ? '1' : (i * 5).toString(),
                      style: LuckitTypos.suitR12.copyWith(
                        color: LuckitColors.main,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
}

class CustomIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;

  const CustomIconButton(
      {required this.iconPath, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) => Material(
        color: LuckitColors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          onTap: onTap,
          child: SvgPicture.asset(
            // TODO(dodo): rounded right/left arrow
            iconPath,
            height: 24.0,
            width: 24.0,
            colorFilter: const ColorFilter.mode(
              LuckitColors.gray80,
              BlendMode.srcIn,
            ),
          ),
        ),
      );
}
