import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../../common/widgets/rounded_grey_text_widget.dart';
import '../data/profile_data.dart';
import '../decoration/profile_box_decoration.dart';
import 'go_farm_widget.dart';

class ProfileGoalArchivingWidget extends StatelessWidget {
  final bool opened;
  final VoidCallback onTap;

  const ProfileGoalArchivingWidget({
    required this.opened,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: profileBoxDecoration,
        padding: const EdgeInsets.symmetric(horizontal: 16.0)
            .copyWith(top: 12.0, bottom: 12.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '나는 바리바리스타',
                    style: LuckitTypos.suitR14
                        .copyWith(color: LuckitColors.gray80, height: 0.0),
                  ),
                ),
                const RoundedGreyTextWidget(label: '성공 미션 74개'),
                const SizedBox(width: 12.0),
                Material(
                  color: LuckitColors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: onTap,
                    child: SvgPicture.asset(opened
                        ? Assets.roundedArrowUp
                        : Assets.roundedArrowDown),
                  ),
                ),
              ],
            ),
            if (opened) const SizedBox(height: 16.0,),
            if (opened) GoFarmWidget(),
            if (opened) const SizedBox(height: 16.0),
            if (opened)
              SizedBox(
                height: 132.0,
                child: AbsorbPointer(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 12.0,
                      mainAxisExtent: 32.0,
                    ),
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) =>
                        data[index],
                  ),
                ),
              )
          ],
        ),
      );
}
