import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

final _medicationsProvider = StreamProvider<List<Medication>>((ref) {
  return ref.watch(medicationRepositoryProvider).watchMedications(activeOnly: false);
});

final _todayMedLogsProvider = StreamProvider<List<MedicationLog>>((ref) {
  return ref.watch(medicationRepositoryProvider).watchLogsForDay(DateTime.now());
});

class MedicationScreen extends ConsumerWidget {
  const MedicationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medsAsync = ref.watch(_medicationsProvider);
    final logsAsync = ref.watch(_todayMedLogsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Medikamente')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Heute'),
            const SizedBox(height: 8),
            TraumCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: medsAsync.when(
                  data: (meds) {
                    final slots = meds.map((m) {
                      final timings = (json.decode(m.timings) as List<dynamic>).cast<String>();
                      final timing = timings.isNotEmpty ? timings.first : '08:00';
                      final logs = logsAsync.value ?? [];
                      final taken = logs.any((l) => l.medicationId == m.id && l.taken);
                      return MedicationSlot(time: timing, taken: taken, medicationId: m.id);
                    }).toList();
                    return MedicationDotRow(
                      slots: slots,
                      onTap: (i) async {
                        final slot = slots[i];
                        if (slot.medicationId == null) return;
                        final logs = logsAsync.value ?? [];
                        final existing = logs.where((l) => l.medicationId == slot.medicationId).firstOrNull;
                        if (existing != null) {
                          await ref.read(medicationRepositoryProvider).updateLog(
                            existing.copyWith(taken: !existing.taken, takenAt: Value(!existing.taken ? DateTime.now() : null)));
                        } else {
                          await ref.read(medicationRepositoryProvider).insertLog(
                            MedicationLogsCompanion.insert(
                              medicationId: slot.medicationId!,
                              scheduledAt: DateTime.now(),
                              taken: const Value(true),
                              takenAt: Value(DateTime.now()),
                            ),
                          );
                        }
                      },
                    );
                  },
                  loading: () => const ShimmerLoader(height: 44),
                  error: (e, _) => Text(e.toString()),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SectionHeader(title: 'Meine Medikamente'),
            const SizedBox(height: 8),
            medsAsync.when(
              data: (meds) => Column(
                children: meds.map((m) => _MedicationTile(
                  medication: m,
                  onDelete: () => ref.read(medicationRepositoryProvider).deleteMedication(m.id),
                )).toList(),
              ),
              loading: () => const ShimmerLoader(),
              error: (e, _) => Text(e.toString()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final dosageCtrl = TextEditingController();
    final timingCtrl = TextEditingController(text: '08:00');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Medikament hinzufügen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 8),
            TextField(controller: dosageCtrl, decoration: const InputDecoration(labelText: 'Dosierung')),
            const SizedBox(height: 8),
            TextField(controller: timingCtrl, decoration: const InputDecoration(labelText: 'Uhrzeit (HH:MM)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () async {
              if (nameCtrl.text.trim().isEmpty) return;
              await ref.read(medicationRepositoryProvider).insertMedication(
                    MedicationsCompanion.insert(
                      name: nameCtrl.text.trim(),
                      dosage: Value(dosageCtrl.text.trim().isEmpty ? null : dosageCtrl.text.trim()),
                      timings: Value(json.encode([timingCtrl.text.trim()])),
                      isActive: const Value(true),
                    ),
                  );
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Hinzufügen'),
          ),
        ],
      ),
    );
  }
}

class _MedicationTile extends StatelessWidget {
  const _MedicationTile({required this.medication, required this.onDelete});
  final Medication medication;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TraumCard(
        child: ListTile(
          leading: const Icon(Icons.medication_rounded, color: TraumColors.cyanBlue),
          title: Text(medication.name),
          subtitle: Text(medication.dosage ?? ''),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Switch(value: medication.isActive, onChanged: (_) {}),
              IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline, color: TraumColors.onBackgroundMuted)),
            ],
          ),
        ),
      ),
    );
  }
}
