import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../profile/data/profile_data.dart';

class AnimalGlass extends StatelessWidget {
  const AnimalGlass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (isLandscape) return Container(); // 세로 모드일 때는 빈 컨테이너 반환

    return Center(
      child: Container(
        // constraints: BoxConstraints(
        //   maxHeight: MediaQuery.of(context).size.height * 0.6,
        // ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 15,
                    color: const Color(0xFF2F56A5).withOpacity(0.15),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
                color: LuckitColors.white.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 18, 10, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '총 74마리',
                      style: LuckitTypos.suitSB16
                          .copyWith(color: LuckitColors.white),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ...List.generate(
                      data.length,
                      (int index) => Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(color: LuckitColors.white, borderRadius: BorderRadius.circular(8)),
                            width: 64,
                            height: 32,
                            child: data[index],
                          ),
                          SizedBox(height: 12,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
