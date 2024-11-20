import 'package:flutter/material.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class MissionCompleteDialog extends StatelessWidget {
  final String missionTitle;
  final VoidCallback onComplete;
  
  const MissionCompleteDialog({
    required this.missionTitle,
    required this.onComplete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: LuckitColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              missionTitle,
              style: LuckitTypos.suitR12.copyWith(
                color: LuckitColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              '목표를 달성하셨나요?',
              style: LuckitTypos.suitSB16.copyWith(
                color: LuckitColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '목표를 달성하셨다면 보상이 지급돼요.',
              style: LuckitTypos.suitR16.copyWith(
                color: LuckitColors.gray80,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      '취소',
                      style: LuckitTypos.suitR16.copyWith(
                        color: LuckitColors.gray80,
                      ),
                    ),
                  ),
                ),
                Container(width: 1, height: 40, color: LuckitColors.gray10,),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      onComplete();
                      Navigator.pop(context);
                    },
                    child: Text(
                      '목표 달성',
                      style: LuckitTypos.suitR16.copyWith(
                        color: LuckitColors.main,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 