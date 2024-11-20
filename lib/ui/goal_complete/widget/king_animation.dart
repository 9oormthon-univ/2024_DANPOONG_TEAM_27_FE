import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../common/consts/assets.dart';

class KingAnimation extends StatefulWidget {
  final String appearAnimation;
  final String stopAnimation;

  const KingAnimation({
    required this.appearAnimation,
    required this.stopAnimation,
    super.key,
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

    _appearController.addStatusListener((AnimationStatus status) {
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
  Widget build(BuildContext context) => Container(
        width: 224,
        height: 224,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.kingBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Center(
              child: Transform.scale(
                scale: 2.4,
                child: showStopAnimation
                    ? Lottie.asset(
                        widget.stopAnimation,
                        controller: _stopController,
                        onLoaded: (LottieComposition composition) {
                          _stopController
                            ..duration = composition.duration
                            ..forward();
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          debugPrint('Lottie 에러: $error');
                          return const SizedBox.shrink(); // 또는 다른 대체 위젯
                        },
                      )
                    : Lottie.asset(
                        widget.appearAnimation,
                        controller: _appearController,
                        onLoaded: (LottieComposition composition) {
                          _appearController..duration = composition.duration
                          ..forward();
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          debugPrint('Lottie 에러: $error');
                          return const SizedBox.shrink(); // 또는 다른 대체 위젯
                        },
                      ),
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration:
                  _appearController.duration ?? const Duration(seconds: 1),
              builder: (BuildContext context, double value, Widget? child) =>
                  Positioned(
                top: 20,
                left: -40 + (30 * value),
                child: child!,
              ),
              child: SvgPicture.asset(Assets.cloud1),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration:
                  _appearController.duration ?? const Duration(seconds: 1),
              builder: (BuildContext context, double value, Widget? child) =>
                  Positioned(
                bottom: 60,
                left: -70 + (40 * value),
                child: child!,
              ),
              child: SvgPicture.asset(Assets.cloud2),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration:
                  _appearController.duration ?? const Duration(seconds: 1),
              builder: (BuildContext context, double value, Widget? child) =>
                  Positioned(
                top: 100,
                right: -85 + (25 * value),
                child: child!,
              ),
              child: SvgPicture.asset(Assets.cloud3),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration:
                  _appearController.duration ?? const Duration(seconds: 1),
              builder: (BuildContext context, double value, Widget? child) =>
                  Positioned(
                bottom: 20,
                right: 10 - (30 * value),
                child: child!,
              ),
              child: SvgPicture.asset(Assets.cloud4),
            ),
          ],
        ),
      );
}
