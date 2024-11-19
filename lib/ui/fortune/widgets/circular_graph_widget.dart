import 'dart:math';

import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class CircularGraphWidget extends StatelessWidget {
  const CircularGraphWidget({
    required this.percentage,
    required this.gradiantStart,
    required this.gradiantEnd,
    required this.timeTitle,
    this.stops,
    super.key,
  });

  final int percentage;
  final Color gradiantStart;
  final Color gradiantEnd;
  final String timeTitle;
  final List<double>? stops;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 80,
            width: 80,
            child: CustomPaint(
              painter: CircularGraphPainter(
                percentage: percentage,
                gradiantStart: gradiantStart,
                gradiantEnd: gradiantEnd,
                stops: stops,
              ),
              child: Center(
                child: Text(
                  '$percentage',
                  style: LuckitTypos.suitR12.copyWith(
                    color: LuckitColors.gray80,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            timeTitle,
            style: LuckitTypos.suitR12.copyWith(
              color: LuckitColors.gray80,
            ),
          ),
        ],
      );
}

class CircularGraphPainter extends CustomPainter {
  CircularGraphPainter({
    required this.percentage,
    required this.gradiantStart,
    required this.gradiantEnd,
    this.stops,
  });

  final int percentage;
  final Color gradiantStart;
  final Color gradiantEnd;
  final List<double>? stops;

  @override
  void paint(Canvas canvas, Size size) {
    // 기본 배경 원 (회색)
    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    // 전면 원 (파란색)
    final Paint foregroundPaint = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          gradiantStart,
          gradiantEnd,
        ],
        stops: stops,
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ))
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    // 배경 원 그리기
    canvas.drawCircle(center, radius, backgroundPaint);

    // 전면 원 그리기 (90%)
    final double sweepAngle = -2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // 시작 각도 (12시 방향)
      sweepAngle, // 끝 각도
      false,
      foregroundPaint,
    );
  }

  // 값 변경 시 재렌더링을 위해 true로 설정 가능
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
