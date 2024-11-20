import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../common/consts/assets.dart';

class KingAnimation extends StatefulWidget {
  final String appearAnimation;
  final String stopAnimation;
  
  const KingAnimation({
    super.key,
    required this.appearAnimation,
    required this.stopAnimation,
  });

  @override
  State<KingAnimation> createState() => _KingAnimationState();
}

class _KingAnimationState extends State<KingAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _appearController;
  late final AnimationController _stopController;
  bool showStopAnimation = false;

  @override
  void initState() {
    super.initState();
    _appearController = AnimationController(vsync: this);
    _stopController = AnimationController(vsync: this);

    _appearController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showStopAnimation = true;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _appearController.dispose();
    _stopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 224,
      height: 224,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.kingBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Transform.scale(
              scale: 2.4,
              child: showStopAnimation
                  ? Lottie.asset(
                      widget.stopAnimation,
                      controller: _stopController,
                      onLoaded: (composition) {
                        _stopController.duration = composition.duration;
                        _stopController.forward();
                      },
                    )
                  : Lottie.asset(
                      widget.appearAnimation,
                      controller: _appearController,
                      onLoaded: (composition) {
                        _appearController.duration = composition.duration;
                        _appearController.forward();
                      },
                    ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: _appearController.duration ?? const Duration(seconds: 1),
            builder: (context, value, child) {
              return Positioned(
                top: 20,
                left: -40 + (30 * value),
                child: child!,
              );
            },
            child: SvgPicture.asset(Assets.cloud1),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: _appearController.duration ?? const Duration(seconds: 1),
            builder: (context, value, child) {
              return Positioned(
                bottom: 60,
                left: -70 + (40 * value),
                child: child!,
              );
            },
            child: SvgPicture.asset(Assets.cloud2),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: _appearController.duration ?? const Duration(seconds: 1),
            builder: (context, value, child) {
              return Positioned(
                top: 100,
                right: -85 + (25 * value),
                child: child!,
              );
            },
            child: SvgPicture.asset(Assets.cloud3),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: _appearController.duration ?? const Duration(seconds: 1),
            builder: (context, value, child) {
              return Positioned(
                bottom: 20,
                right: 10 - (30 * value),
                child: child!,
              );
            },
            child: SvgPicture.asset(Assets.cloud4),
          ),
        ],
      ),
    );
  }
}