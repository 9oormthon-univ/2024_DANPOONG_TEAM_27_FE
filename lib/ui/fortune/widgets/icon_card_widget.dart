import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';
import '../../common/consts/assets.dart';
import '../fortune_state.dart';
import '../fortune_view_model.dart';

class IconCardListWidget extends ConsumerWidget {
  const IconCardListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FortuneState state = ref.watch(fortuneViewModelProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //TODO(재훈): Enum으로 관리(?)
          IconCardWidget(
            selected: state.selectdTitle == '총운',
            icon: Assets.chartOutlined,
            selectedIcon: Assets.chartFilled,
            title: '총운',
          ),
          IconCardWidget(
            selected: state.selectdTitle == '애정운',
            icon: Assets.heartOutlined,
            selectedIcon: Assets.heartFilled,
            title: '애정운',
          ),
          IconCardWidget(
            selected: state.selectdTitle == '금전운',
            icon: Assets.pigOutlined,
            selectedIcon: Assets.pigFilled,
            title: '금전운',
          ),
          IconCardWidget(
            selected: state.selectdTitle == '직장운',
            icon: Assets.buildingOutlined,
            selectedIcon: Assets.buildingFilled,
            title: '직장운',
          ),
          IconCardWidget(
            selected: state.selectdTitle == '학업운',
            icon: Assets.bookOutlined,
            selectedIcon: Assets.bookFilled,
            title: '학업운',
          ),
          IconCardWidget(
            selected: state.selectdTitle == '건강운',
            icon: Assets.healthOutlined,
            selectedIcon: Assets.healthFilled,
            title: '건강운',
          ),
        ],
      ),
    );
  }
}

class IconCardWidget extends ConsumerWidget {
  const IconCardWidget({
    required this.selected,
    required this.title,
    required this.icon,
    required this.selectedIcon,
    super.key,
  });

  final bool selected;
  final String title;
  final String icon;
  final String selectedIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FortuneViewModel viewModel =
        ref.read(fortuneViewModelProvider.notifier);
    return GestureDetector(
      onTap: () {
        viewModel.onSelectFortune(title: title);
      },
      child: Container(
        width: 50,
        height: 70,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: selected
                ? const <double>[
                    0.42,
                    1,
                  ]
                : <double>[0],
            colors: selected
                ? <Color>[
                    LuckitColors.gradient1Stop42,
                    LuckitColors.gradient1Stop100.withOpacity(0.7),
                  ]
                : <Color>[
                    LuckitColors.transparent,
                  ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              colorFilter: ColorFilter.mode(
                selected ? LuckitColors.gray10 : LuckitColors.gray20,
                BlendMode.srcIn,
              ),
              selected ? selectedIcon : icon,
              width: 40,
              height: 40,
            ),
            Text(title,
                style: LuckitTypos.suitR12.copyWith(
                  color: selected ? LuckitColors.white : LuckitColors.gray60,
                )),
          ],
        ),
      ),
    );
  }
}
