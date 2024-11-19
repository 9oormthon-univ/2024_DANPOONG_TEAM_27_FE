import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<CustomNavigationBarItem> items;

  const CustomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 27.0),
      padding: EdgeInsets.symmetric(horizontal: 48.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (index) {
          return InkWell(
            onTap: () => onTap(index),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  currentIndex == index
                      ? SvgPicture.asset(items[index].activeIcon)
                      : SvgPicture.asset(
                    items[index].icon,
                    // color: Color(0xFFD0D6E1),
                  ),
                  SizedBox(height: 4),
                  Text(
                    items[index].label,
                    style: TextStyle(
                      color: currentIndex == index ? Colors.blue : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
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