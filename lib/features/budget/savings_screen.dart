import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

class SavingsScreen extends ConsumerWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(budgetRepositoryProvider);

    return Scaffold(
      backgroundColor: TraumColors.background,
      appBar: AppBar(
        backgroundColor: TraumColors.surface,
        elevation: 0,
        title: const Text(
          'Sparziele & Schulden',
          style: TextStyle(
            color: TraumColors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: TraumColors.onBackground),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Sparziele'),
            const SizedBox(height: 12),
            StreamBuilder<List<SavingsGoal>>(
              stream: repo.watchSavingsGoals(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerLoader(height: 80);
                }
                final goals = snapshot.data ?? [];
                if (goals.isEmpty) {
                  return TraumCard(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'Noch keine Sparziele vorhanden.',
                        style: const TextStyle(
                            color: TraumColors.onBackgroundMuted),
                      ),
                    ),
                  );
                }
                return Column(
                  children: goals.map((goal) {
                    final progress = goal.targetAmount > 0
                        ? (goal.currentAmount / goal.targetAmount)
                            .clamp(0.0, 1.0)
                        : 0.0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TraumCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    goal.name,
                                    style: const TextStyle(
                                      color: TraumColors.onBackground,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (goal.isCompleted)
                                  const Icon(Icons.check_circle,
                                      color: TraumColors.success, size: 18),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 8,
                                backgroundColor: TraumColors.surfaceVariant,
                                valueColor:
                                    const AlwaysStoppedAnimation<Color>(
                                        TraumColors.cyanBlue),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${goal.currentAmount.toStringAsFixed(2)} / ${goal.targetAmount.toStringAsFixed(2)} €',
                              style: const TextStyle(
                                color: TraumColors.onBackgroundMuted,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 24),
            const SectionHeader(title: 'Schulden'),
            const SizedBox(height: 12),
            StreamBuilder<List<Debt>>(
              stream: repo.watchDebts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerLoader(height: 80);
                }
                final debts = snapshot.data ?? [];
                if (debts.isEmpty) {
                  return TraumCard(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'Keine Schulden eingetragen.',
                        style: const TextStyle(
                            color: TraumColors.onBackgroundMuted),
                      ),
                    ),
                  );
                }
                return Column(
                  children: debts.map((debt) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TraumCard(
                        child: ListTile(
                          title: Text(
                            debt.creditor,
                            style: const TextStyle(
                                color: TraumColors.onBackground,
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '${debt.remainingAmount.toStringAsFixed(2)} €',
                            style: const TextStyle(
                                color: TraumColors.onBackgroundMuted,
                                fontSize: 13),
                          ),
                          trailing: Icon(
                            Icons.check_circle,
                            color: debt.isPaidOff
                                ? TraumColors.success
                                : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TraumColors.cyanBlue,
                      foregroundColor: TraumColors.background,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.savings_outlined, size: 18),
                    label: const Text('Sparziel hinzufügen',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () =>
                        _showAddGoalDialog(context, ref),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TraumColors.coralOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.credit_card_outlined, size: 18),
                    label: const Text('Schuld hinzufügen',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () =>
                        _showAddDebtDialog(context, ref),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddGoalDialog(
      BuildContext context, WidgetRef ref) async {
    final nameCtrl = TextEditingController();
    final targetCtrl = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: TraumColors.surface,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Sparziel hinzufügen',
          style: TextStyle(color: TraumColors.onBackground),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              style: const TextStyle(color: TraumColors.onBackground),
              decoration: _inputDeco('Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: targetCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: TraumColors.onBackground),
              decoration: _inputDeco('Zielbetrag (€)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Abbrechen',
                style: TextStyle(color: TraumColors.onBackgroundMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: TraumColors.cyanBlue,
              foregroundColor: TraumColors.background,
            ),
            onPressed: () async {
              final name = nameCtrl.text.trim();
              final target =
                  double.tryParse(targetCtrl.text.replaceAll(',', '.'));
              if (name.isEmpty || target == null || target <= 0) return;
              await ref.read(budgetRepositoryProvider).insertSavingsGoal(
                    SavingsGoalsCompanion.insert(
                      name: name,
                      targetAmount: target,
                    ),
                  );
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );

    nameCtrl.dispose();
    targetCtrl.dispose();
  }

  Future<void> _showAddDebtDialog(
      BuildContext context, WidgetRef ref) async {
    final creditorCtrl = TextEditingController();
    final amountCtrl = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: TraumColors.surface,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Schuld hinzufügen',
          style: TextStyle(color: TraumColors.onBackground),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: creditorCtrl,
              style: const TextStyle(color: TraumColors.onBackground),
              decoration: _inputDeco('Gläubiger'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: TraumColors.onBackground),
              decoration: _inputDeco('Betrag (€)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Abbrechen',
                style: TextStyle(color: TraumColors.onBackgroundMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: TraumColors.coralOrange,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final creditor = creditorCtrl.text.trim();
              final amount =
                  double.tryParse(amountCtrl.text.replaceAll(',', '.'));
              if (creditor.isEmpty || amount == null || amount <= 0) return;
              await ref.read(budgetRepositoryProvider).insertDebt(
                    DebtsCompanion.insert(
                      creditor: creditor,
                      originalAmount: amount,
                      remainingAmount: amount,
                    ),
                  );
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );

    creditorCtrl.dispose();
    amountCtrl.dispose();
  }

  InputDecoration _inputDeco(String label) => InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(color: TraumColors.onBackgroundMuted),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: TraumColors.surfaceVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: TraumColors.cyanBlue),
        ),
        filled: true,
        fillColor: TraumColors.surfaceVariant,
      );
}
