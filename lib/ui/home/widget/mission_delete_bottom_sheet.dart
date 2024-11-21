import 'package:flutter/material.dart';
import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class MissionDeleteBottomSheet extends StatelessWidget {
  final String title;
  const MissionDeleteBottomSheet({required this.title, super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 4.0, bottom: 36.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      title,
                      style: LuckitTypos.suitSB16
                          .copyWith(color: LuckitColors.black),
                    ),
                  ],
                ),
              ),
              Text(
                '이 미션을 정말로 삭제하시겠습니까?',
                style: LuckitTypos.suitSB16.copyWith(
                  color: LuckitColors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '삭제하면 되돌릴 수 없어요.',
                style: LuckitTypos.suitR16.copyWith(
                  color: LuckitColors.gray80,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: <Widget>[
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
                  Container(
                    width: 1,
                    height: 40,
                    color: LuckitColors.gray10,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        // TODO: 삭제 로직 구현
                        Navigator.pop(context);
                      },
                      child: Text(
                        '삭제하기',
                        style: LuckitTypos.suitR16.copyWith(
                          color: LuckitColors.error,
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
