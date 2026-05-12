import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/radius.dart';

class TraumCard extends StatelessWidget {
  const TraumCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.borderRadius,
    this.onTap,
    this.margin,
    this.glow = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  /// Set true to add a subtle CoralOrange glow (active/highlighted state).
  final bool glow;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? TraumRadius.card;
    Widget card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? TraumColors.surface,
        borderRadius: radius,
        border: Border.all(color: TraumColors.cardBorder),
        boxShadow: glow ? const [TraumColors.coralGlow] : null,
      ),
      child: padding != null
          ? Padding(padding: padding!, child: child)
          : child,
    );

    if (onTap != null) {
      card = GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}
