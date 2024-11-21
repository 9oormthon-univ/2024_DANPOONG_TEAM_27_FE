import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';

final BoxDecoration profileBoxDecoration = BoxDecoration(
  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
  color: LuckitColors.white,
  boxShadow: <BoxShadow>[
    BoxShadow(
      color: LuckitColors.shadow2.withOpacity(0.15),
      blurRadius: 10.0,
    ),
  ],
);
