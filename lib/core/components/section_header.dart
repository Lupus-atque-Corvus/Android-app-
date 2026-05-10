import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.onShowAll,
    this.showAllLabel = 'Alle anzeigen',
    this.trailing,
  });

  final String title;
  final VoidCallback? onShowAll;
  final String showAllLabel;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: TraumColors.onBackground,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (trailing != null) trailing!,
        if (onShowAll != null && trailing == null)
          TextButton(
            onPressed: onShowAll,
            style: TextButton.styleFrom(
              foregroundColor: TraumColors.cyanBlue,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: Text(
              showAllLabel,
              style: const TextStyle(
                color: TraumColors.cyanBlue,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }
}
