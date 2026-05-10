import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'gradient_progress_bar.dart';

class BudgetCategoryBar extends StatelessWidget {
  const BudgetCategoryBar({
    super.key,
    required this.label,
    required this.value,
    required this.limit,
    this.currencySymbol = '€',
  });

  final String label;
  final double value;
  final double limit;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final ratio = limit > 0 ? value / limit : 0.0;
    final isOver = ratio > 1.0;
    final pct = (ratio * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: TraumColors.onBackground,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              '${value.toStringAsFixed(0)} / ${limit.toStringAsFixed(0)} $currencySymbol',
              style: TextStyle(
                color: isOver ? TraumColors.error : TraumColors.onBackgroundMuted,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$pct%',
              style: TextStyle(
                color: isOver ? TraumColors.error : TraumColors.onBackgroundMuted,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        GradientProgressBar(
          value: ratio.clamp(0.0, 1.0),
          gradient: isOver
              ? LinearGradient(
                  colors: [TraumColors.error, TraumColors.error])
              : TraumColors.gradientCool,
          height: 6,
        ),
      ],
    );
  }
}
