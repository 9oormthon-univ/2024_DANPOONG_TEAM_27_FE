import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../../ui/common/consts/assets.dart';
import 'add_mission_bottom_sheet.dart';
import 'mission_delete_bottom_sheet.dart';

class MissionManageBottomSheet extends StatelessWidget {
  final String title;

  const MissionManageBottomSheet({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    void _showEditMissionBottomSheet() {
      showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddMissionBottomSheet(
            title: '미션 수정',
            subtitle: '미션 내용을 수정해보세요!',
            buttonLabel: '수정완료',
            initialText: '거울 볼 때마다 미소짓기',
          ),
        ),
      ).then((String? missionText) {
        if (missionText != null) {
          // 수정 로직
        }
      });
    }

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: LuckitTypos.suitSB16.copyWith(
                    color: LuckitColors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.edit,
                    colorFilter: const ColorFilter.mode(
                      LuckitColors.gray60,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '할 일 수정하기',
                    style: LuckitTypos.suitSB16.copyWith(
                      color: LuckitColors.gray80,
                    ),
                  ),
                ],
              ),
            ),
            onTap: _showEditMissionBottomSheet,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            width: double.infinity,
            height: 1,
            color: LuckitColors.gray10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) =>
                    const MissionDeleteBottomSheet(
                  title: '거울 볼 때마다 미소짓기',
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.delete,
                    colorFilter: const ColorFilter.mode(
                      LuckitColors.error,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '할 일 삭제하기',
                    style: LuckitTypos.suitSB16.copyWith(
                      color: LuckitColors.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
