import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/luckit_colors.dart';
import '../../../../theme/luckit_typos.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<CustomNavigationBarItem> items;

  const CustomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 27.0),
        padding: const EdgeInsets.symmetric(horizontal: 48.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
              items.length,
              (int index) => InkWell(
                    onTap: () => onTap(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (currentIndex == index)
                            SvgPicture.asset(items[index].activeIcon)
                          else
                            SvgPicture.asset(
                              items[index].icon,
                              // color: Color(0xFFD0D6E1),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            items[index].label,
                            style: LuckitTypos.suitSB12.copyWith(
                                color: currentIndex == index
                                    ? LuckitColors.main
                                    : LuckitColors.gray20),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      );
}

class CustomNavigationBarItem {
  final String icon;
  final String activeIcon;
  final String label;

  CustomNavigationBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
