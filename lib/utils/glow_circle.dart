import 'package:flutter/material.dart';

import 'constants.dart';



void drawGlowingCircle(
    Canvas canvas,
    Size size,
    Offset center,
    double radius,
    List<Color> gradientColors,
    ) {
  final Gradient gradient = RadialGradient(
    colors: gradientColors,
  );

  final Paint paint = Paint()
    ..shader =
    gradient.createShader(Rect.fromCircle(center: center, radius: radius));

  // Draw the glowing circle with a shadow
  canvas.drawShadow(
    Path()..addOval(Rect.fromCircle(center: center, radius: radius)),
    shadowColor,
    100.0,
    true,
  );

  canvas.drawCircle(center, radius, paint);
}

class GlowingCirclePainter extends CustomPainter {
  final Offset center;

  GlowingCirclePainter({required this.center});

  @override
  void paint(Canvas canvas, Size size) {
    const double radius = 600.0;
    final List<Color> gradientColors = [glowColor, Colors.transparent];

    drawGlowingCircle(canvas, size, center, radius, gradientColors);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}