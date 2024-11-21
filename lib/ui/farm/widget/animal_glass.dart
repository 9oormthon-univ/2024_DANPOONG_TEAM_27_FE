import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../profile/data/profile_data.dart';

class AnimalGlass extends StatelessWidget {
  const AnimalGlass({
    super.key,
  });

  Widget _portraitAnimal() => Padding(
      padding: const EdgeInsets.fromLTRB(10, 18, 10, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '총 74마리',
            style: LuckitTypos.suitSB16
                .copyWith(color: LuckitColors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          ...List.generate(
            data.length,
                (int index) => Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: LuckitColors.white,
                      borderRadius: BorderRadius.circular(8)),
                  width: 64,
                  height: 32,
                  child: data[index],
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );

  Widget _landscapeAnimal() => Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 16, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '총 74마리',
            style: LuckitTypos.suitSB16.copyWith(color: LuckitColors.white),
          ),
          const SizedBox(
            width: 24,
          ),
          ...List.generate(
            data_landscape.length,
            (int index) => Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: LuckitColors.white,
                      borderRadius: BorderRadius.circular(8)),
                  width: 32,
                  height: 64,
                  child: data_landscape[index],
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;



    return Center(
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: DecoratedBox(
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
            child: isLandscape ? _landscapeAnimal() : _portraitAnimal(),
          ),
        ),
      ),
    );
  }
}
