import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

final _supplementsProvider = StreamProvider<List<Supplement>>((ref) {
  return ref.watch(supplementRepositoryProvider).watchSupplements(activeOnly: false);
});

class SupplementScreen extends ConsumerWidget {
  const SupplementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(supplementRepositoryProvider);
    final supplementsAsync = ref.watch(_supplementsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Supplemente')),
      body: supplementsAsync.when(
        data: (supplements) => supplements.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.science_outlined, size: 64, color: TraumColors.onBackgroundSubtle),
                    const SizedBox(height: 16),
                    Text('Noch keine Supplemente',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TraumColors.onBackgroundMuted)),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: supplements.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final s = supplements[i];
                  return _SupplementCard(
                    supplement: s,
                    onToggle: () => repo.updateSupplement(s.copyWith(isActive: !s.isActive)),
                    onDelete: () => repo.deleteSupplement(s.id),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final categoryCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    final unitCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Supplement hinzufügen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 8),
            TextField(controller: categoryCtrl, decoration: const InputDecoration(labelText: 'Kategorie')),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(child: TextField(controller: amountCtrl, decoration: const InputDecoration(labelText: 'Menge'), keyboardType: TextInputType.number)),
              const SizedBox(width: 8),
              Expanded(child: TextField(controller: unitCtrl, decoration: const InputDecoration(labelText: 'Einheit'))),
            ]),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () async {
              if (nameCtrl.text.trim().isEmpty) return;
              await ref.read(supplementRepositoryProvider).insertSupplement(
                    SupplementsCompanion.insert(
                      name: nameCtrl.text.trim(),
                      category: Value(categoryCtrl.text.trim().isEmpty ? null : categoryCtrl.text.trim()),
                      dosageAmount: Value(amountCtrl.text.trim().isEmpty ? null : amountCtrl.text.trim()),
                      dosageUnit: Value(unitCtrl.text.trim().isEmpty ? null : unitCtrl.text.trim()),
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

class _SupplementCard extends StatelessWidget {
  const _SupplementCard({required this.supplement, required this.onToggle, required this.onDelete});
  final Supplement supplement;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.science_rounded, color: supplement.isActive ? TraumColors.cyanBlue : TraumColors.onBackgroundSubtle),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(supplement.name, style: Theme.of(context).textTheme.bodyMedium),
                  if (supplement.dosageAmount != null || supplement.dosageUnit != null)
                    Text('${supplement.dosageAmount ?? ''} ${supplement.dosageUnit ?? ''}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.onBackgroundMuted)),
                ],
              ),
            ),
            Switch(value: supplement.isActive, onChanged: (_) => onToggle()),
            IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline, color: TraumColors.onBackgroundMuted)),
          ],
        ),
      ),
    );
  }
}
