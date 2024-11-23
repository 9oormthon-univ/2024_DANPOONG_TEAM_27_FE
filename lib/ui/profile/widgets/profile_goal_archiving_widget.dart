import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../domain/goal/model/complete_goal_model.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../../common/widgets/rounded_grey_text_widget.dart';
import '../decoration/profile_box_decoration.dart';
import 'go_farm_widget.dart';

class ProfileGoalArchivingWidget extends StatelessWidget {
  final VoidCallback onTap;
  final CompleteGoalModel goalModel;

  const ProfileGoalArchivingWidget({
    required this.onTap,
    required this.goalModel,
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
                    goalModel.name,
                    style: LuckitTypos.suitR14
                        .copyWith(color: LuckitColors.gray80, height: 0.0),
                  ),
                ),
                RoundedGreyTextWidget(
                    label: '성공 미션 ${goalModel.countSuccessTodo}개'),
                const SizedBox(width: 12.0),
                Material(
                  color: LuckitColors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: onTap,
                    child: SvgPicture.asset(
                      goalModel.opened
                          ? Assets.roundedArrowUp
                          : Assets.roundedArrowDown,
                    ),
                  ),
                ),
              ],
            ),
            if (goalModel.opened)
              const SizedBox(
                height: 16.0,
              ),
            if (goalModel.opened) GoFarmWidget(goalModel: goalModel,),
            if (goalModel.opened) const SizedBox(height: 16.0),
            if (goalModel.opened)
              SizedBox(
                height: 132.0,
                child: goalModel.characterWidgetList != null
                    ? AbsorbPointer(
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
                              goalModel
                                  .characterWidgetList!.goalCharacters[index],
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: LuckitColors.main,
                        ),
                      ),
              )
          ],
        ),
      );
}
