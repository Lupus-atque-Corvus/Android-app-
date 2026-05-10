import 'package:flutter/material.dart';
import '../theme/colors.dart';

class MedicationSlot {
  const MedicationSlot({
    required this.time,
    required this.taken,
    this.medicationId,
  });

  final String time;
  final bool taken;
  final int? medicationId;
}

class MedicationDotRow extends StatelessWidget {
  const MedicationDotRow({
    super.key,
    required this.slots,
    this.onTap,
    this.onAdd,
  });

  final List<MedicationSlot> slots;
  final void Function(int index)? onTap;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...slots.map((slot) {
          final index = slots.indexOf(slot);
          return GestureDetector(
            onTap: onTap != null ? () => onTap!(index) : null,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: slot.taken
                          ? TraumColors.cyanBlue
                          : TraumColors.coralOrange,
                    ),
                    child: Icon(
                      slot.taken ? Icons.check_rounded : Icons.medication_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    slot.time,
                    style: const TextStyle(
                      color: TraumColors.onBackgroundMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        if (onAdd != null)
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: TraumColors.onBackgroundSubtle,
                ),
              ),
              child: const Icon(
                Icons.add_rounded,
                color: TraumColors.onBackgroundMuted,
                size: 18,
              ),
            ),
          ),
      ],
    );
  }
}
