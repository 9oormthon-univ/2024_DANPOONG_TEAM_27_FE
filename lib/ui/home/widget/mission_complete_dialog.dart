import 'package:flutter/material.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class MissionCompleteDialog extends StatelessWidget {
  final String? missionTitle;
  final String mainText;
  final String? descriptionText;
  final String rightButtonLabel;
  final Color? rightButtonColor;
  final VoidCallback onComplete;

  const MissionCompleteDialog({
    required this.missionTitle,
    required this.onComplete,
    this.mainText = '목표를 달성하셨나요?',
    this.descriptionText = '목표를 달성하셨다면 보상이 지급돼요.',
    super.key,
    this.rightButtonLabel = '목표 달성',
    this.rightButtonColor,
  });

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: LuckitColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (missionTitle != null)
                Text(
                  missionTitle!,
                  style: LuckitTypos.suitR12.copyWith(
                    color: LuckitColors.black,
                  ),
                  textAlign: TextAlign.center,
                )
              else
                const SizedBox(height: 20.0),
              const SizedBox(height: 16),
              Text(
                mainText,
                style: LuckitTypos.suitSB16.copyWith(
                  color: LuckitColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (descriptionText != null)
                Text(
                  descriptionText!,
                  style: LuckitTypos.suitR16.copyWith(
                    color: LuckitColors.gray80,
                  ),
                  textAlign: TextAlign.center,
                )
              else
                const SizedBox(height: 12),
              const SizedBox(height: 32),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        overlayColor: LuckitColors.gray40,
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        '취소',
                        style: LuckitTypos.suitR16.copyWith(
                          color: LuckitColors.gray80,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: LuckitColors.gray10,
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        overlayColor: LuckitColors.gray40,
                      ),
                      onPressed: () {
                        onComplete();
                        Navigator.pop(context);
                      },
                      child: Text(
                        rightButtonLabel,
                        style: LuckitTypos.suitR16.copyWith(
                          color: rightButtonColor ?? LuckitColors.main,
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
