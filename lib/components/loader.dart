import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

class BreatheAnimation extends StatefulWidget {
  const BreatheAnimation({super.key});

  @override
  State<BreatheAnimation> createState() => _BreatheAnimationState();
}

class _BreatheAnimationState extends State<BreatheAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: size.width > size.height
          ? EdgeInsets.only(left: size.width * 0.95, top: size.height * 0.91)
          : EdgeInsets.only(left: size.width * 0.85, top: size.height * 0.925),
      child: Center(
        child: CustomPaint(
          painter: _BreathePainter(
              CurvedAnimation(parent: _controller, curve: Curves.ease)),
          size: Size.infinite,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _BreathePainter extends CustomPainter {
  _BreathePainter(
    this.animation, {
    this.count = 6,
    Color color = const Color(0xff005859),
  })  : circlePaint = Paint()
          ..color = color
          ..blendMode = BlendMode.screen,
        super(repaint: animation);

  final Animation<double> animation;
  final int count;
  final Paint circlePaint;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.longestSide * 0.1) * animation.value;
    for (int index = 0; index < count; index++) {
      final indexAngle = (index * math.pi / count * 2);
      final angle = indexAngle + (math.pi * 1.5 * animation.value);
      final offset = Offset(math.sin(angle), math.cos(angle)) * radius * 0.985;
      canvas.drawCircle(center + offset * animation.value, radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(_BreathePainter oldDelegate) =>
      animation != oldDelegate.animation;
}
