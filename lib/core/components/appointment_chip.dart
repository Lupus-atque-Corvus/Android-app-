import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/radius.dart';

class AppointmentChip extends StatelessWidget {
  const AppointmentChip({
    super.key,
    required this.time,
    required this.title,
    required this.accentColor,
    this.onTap,
  });

  final String time;
  final String title;
  final Color accentColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.only(
          start: 0,
          end: 12,
          top: 8,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: TraumColors.surfaceVariant,
          borderRadius: TraumRadius.chip,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 4,
              height: 36,
              margin: const EdgeInsetsDirectional.only(end: 10),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: TraumColors.onBackgroundMuted,
                    fontSize: 12,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: TraumColors.onBackground,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
