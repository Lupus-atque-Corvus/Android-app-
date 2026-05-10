import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CircularProgressRing extends StatelessWidget {
  const CircularProgressRing({
    super.key,
    required this.value,
    required this.centerLabel,
    this.subLabel,
    this.size = 120,
    this.strokeWidth = 12,
    this.gradient = TraumColors.gradientCool,
    this.trackColor = TraumColors.cyanDim,
  });

  final double value;
  final String centerLabel;
  final String? subLabel;
  final double size;
  final double strokeWidth;
  final LinearGradient gradient;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(
          value: value.clamp(0.0, 1.0),
          strokeWidth: strokeWidth,
          gradient: gradient,
          trackColor: trackColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                centerLabel,
                style: const TextStyle(
                  color: TraumColors.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (subLabel != null)
                Text(
                  subLabel!,
                  style: const TextStyle(
                    color: TraumColors.onBackgroundMuted,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.value,
    required this.strokeWidth,
    required this.gradient,
    required this.trackColor,
  });

  final double value;
  final double strokeWidth;
  final LinearGradient gradient;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const startAngle = -pi / 2;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // Fill
    if (value > 0) {
      final sweepAngle = 2 * pi * value;
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradientPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, startAngle, sweepAngle, false, gradientPaint);
    }
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.value != value;
}
