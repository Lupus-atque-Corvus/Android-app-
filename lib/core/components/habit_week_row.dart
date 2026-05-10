import 'package:flutter/material.dart';
import '../theme/colors.dart';

class HabitWeekRow extends StatelessWidget {
  const HabitWeekRow({
    super.key,
    required this.days,
    required this.streak,
    this.todayIndex,
    this.onDayTap,
  });

  final List<bool> days;
  final int streak;
  final int? todayIndex;
  final void Function(int)? onDayTap;

  static const _dayLabels = ['M', 'D', 'M', 'D', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final today = todayIndex ?? DateTime.now().weekday - 1;

    return Row(
      children: [
        // Flame + streak
        const Icon(Icons.local_fire_department_rounded,
            color: TraumColors.coralOrange, size: 22),
        const SizedBox(width: 4),
        Text(
          '$streak',
          style: const TextStyle(
            color: TraumColors.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final isToday = i == today;
              final isDone = i < days.length ? days[i] : false;
              final isFuture = i > today;

              return GestureDetector(
                onTap: onDayTap != null ? () => onDayTap!(i) : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone
                            ? TraumColors.coralOrange
                            : Colors.transparent,
                        border: isToday && !isDone
                            ? Border.all(
                                color: TraumColors.coralOrange,
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: isDone
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 16)
                          : null,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _dayLabels[i],
                      style: TextStyle(
                        color: isFuture
                            ? TraumColors.onBackgroundSubtle
                            : isToday
                                ? TraumColors.coralOrange
                                : TraumColors.onBackgroundMuted,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
