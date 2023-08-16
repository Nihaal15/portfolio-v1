import 'package:flutter/material.dart';

class HoverLine extends StatelessWidget {
  final bool isHovered;
  final Color color;
  final bool isActive;

  const HoverLine(
      {super.key,
      required this.isHovered,
      required this.color,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: (isHovered || isActive) ? 75 : 35,
      child: CustomPaint(
        painter: _LinePainter(isHovered: isHovered, color: color),
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final bool isHovered;
  final Color color;

  _LinePainter({required this.isHovered, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final Offset startPoint = Offset(0, size.height / 2);
    final Offset endPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
