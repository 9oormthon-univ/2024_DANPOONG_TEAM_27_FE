import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/consts/assets.dart';

class CloudConfig {
  final String asset;
  final double startX;
  final double y;
  final double speed;
  final double size;

  CloudConfig({
    required this.asset,
    required this.startX,
    required this.y,
    required this.speed,
    required this.size,
  });

  double getCurrentPosition(double animationValue, double screenWidth) {
    final double totalDistance = screenWidth + size;
    final double position = startX + (animationValue * totalDistance * speed);
    return position % (screenWidth + size) - size;
  }
}

class CloudsOverlay extends StatefulWidget {
  final double gameHeight;

  const CloudsOverlay({
    required this.gameHeight,
    super.key,
  });

  @override
  State<CloudsOverlay> createState() => _CloudsOverlayState();
}

class _CloudsOverlayState extends State<CloudsOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<CloudConfig> clouds;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    )..repeat();

    initializeClouds();
  }

  void initializeClouds() {
    clouds = <CloudConfig>[
      CloudConfig(
        asset: Assets.tutorialCloud1,
        startX: 150,
        y: widget.gameHeight * 0.2,
        speed: 1.2,
        size: widget.gameHeight * 0.2,
      ),
      // CloudConfig(
      //   asset: Assets.tutorialCloud2,
      //   startX: 100,
      //   y: widget.gameHeight * 0.6,
      //   speed: 0.8,
      //   size: widget.gameHeight * 0.25,
      // ),
      CloudConfig(
        asset: Assets.tutorialCloud3,
        startX: 0,
        y: widget.gameHeight - 37,
        speed: 1.0,
        size: widget.gameHeight * 0.22,
      ),
      CloudConfig(
        asset: Assets.tutorialCloud4,
        startX: 3000,
        y: widget.gameHeight * 0.8,
        speed: 0.9,
        size: widget.gameHeight * 0.18,
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: <Widget>[
      ...clouds.map((CloudConfig cloud) => AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          final double position = cloud.getCurrentPosition(
            _controller.value,
            MediaQuery.of(context).size.width,
          );

          return Positioned(
            left: position,
            top: cloud.y,
            child: SvgPicture.asset(
              cloud.asset,
            ),
            // width: cloud.size,    // 추가
            // height: cloud.size,   // 추가
          );
        },
      )),
    ],
  );
}
