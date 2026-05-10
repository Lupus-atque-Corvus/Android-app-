import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ChartSegment {
  const ChartSegment({
    required this.label,
    required this.value,
    required this.color,
    this.formattedAmount,
  });

  final String label;
  final double value;
  final Color color;
  final String? formattedAmount;
}

class DonutChart extends StatelessWidget {
  const DonutChart({
    super.key,
    required this.segments,
    this.centerSpaceRadius = 50,
    this.showLegend = true,
  });

  final List<ChartSegment> segments;
  final double centerSpaceRadius;
  final bool showLegend;

  @override
  Widget build(BuildContext context) {
    final total = segments.fold(0.0, (sum, s) => sum + s.value);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 160,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: centerSpaceRadius,
                sectionsSpace: 2,
                sections: segments.map((s) {
                  return PieChartSectionData(
                    value: s.value,
                    color: s.color,
                    showTitle: false,
                    radius: 40,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        if (showLegend) ...[
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: segments.map((s) {
                final pct = total > 0 ? (s.value / total * 100).round() : 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: s.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          s.label,
                          style: const TextStyle(
                            color: TraumColors.onBackgroundMuted,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        s.formattedAmount ?? '$pct%',
                        style: const TextStyle(
                          color: TraumColors.onBackground,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
