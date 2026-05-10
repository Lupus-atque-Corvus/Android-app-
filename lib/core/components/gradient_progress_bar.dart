import 'package:flutter/material.dart';
import '../theme/colors.dart';

class GradientProgressBar extends StatelessWidget {
  const GradientProgressBar({
    super.key,
    required this.value,
    this.gradient = TraumColors.gradientCool,
    this.height = 8,
    this.radius = 4,
  });

  final double value;
  final LinearGradient gradient;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final fillWidth = (value.clamp(0.0, 1.0) * width);

        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: TraumColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: height,
                width: fillWidth,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
