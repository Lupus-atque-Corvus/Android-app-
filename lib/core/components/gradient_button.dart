import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/radius.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.gradient = TraumColors.gradientWarm,
    this.width = double.infinity,
    this.height = 52,
    this.icon,
  });

  final VoidCallback? onPressed;
  final String label;
  final LinearGradient gradient;
  final double width;
  final double height;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: onPressed != null ? gradient : null,
          color: onPressed != null ? null : TraumColors.onBackgroundSubtle,
          borderRadius: TraumRadius.button,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: TraumRadius.button,
          child: InkWell(
            onTap: onPressed,
            borderRadius: TraumRadius.button,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
