import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart' show nutritionRepositoryProvider, todayWaterLogsProvider;
import '../../core/providers/preferences_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../core/navigation/routes.dart';
import '../../core/theme/colors.dart';
import 'package:drift/drift.dart' show Value;
import '../../data/database/traum_database.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Stream providers
// ─────────────────────────────────────────────────────────────────────────────

final _nutritionLogsProvider =
    StreamProvider.autoDispose<List<NutritionLog>>((ref) {
  return ref.watch(nutritionRepositoryProvider).watchLogsForDay(DateTime.now());
});

// ─────────────────────────────────────────────────────────────────────────────
// NutritionScreen
// ─────────────────────────────────────────────────────────────────────────────

class NutritionScreen extends ConsumerWidget {
  const NutritionScreen({super.key});

  static const _mealTypes = [
    (key: 'breakfast', label: 'Frühstück', icon: Icons.free_breakfast_outlined),
    (key: 'lunch', label: 'Mittagessen', icon: Icons.lunch_dining_outlined),
    (key: 'dinner', label: 'Abendessen', icon: Icons.dinner_dining_outlined),
    (key: 'snack', label: 'Snacks', icon: Icons.cookie_outlined),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(_nutritionLogsProvider);
    final waterAsync = ref.watch(todayWaterLogsProvider);
    final kcalGoal = ref.watch(kcalGoalProvider);
    final proteinGoal = ref.watch(proteinGoalGProvider);
    final waterGoal = ref.watch(waterGoalMlProvider);
    // Carbs goal: rough default of 50 % of kcal / 4 kcal per gram
    final carbGoal = (kcalGoal * 0.5 / 4).round();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).nutritionTitle),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // ── Heute ─────────────────────────────────────────────────
                    SectionHeader(title: AppLocalizations.of(context).homeTodayLabel),
                    const SizedBox(height: 10),

                    // Macro summary card
                    logsAsync.when(
                      data: (logs) => _MacroCard(
                        logs: logs,
                        kcalGoal: kcalGoal,
                        proteinGoal: proteinGoal,
                        carbGoal: carbGoal,
                      ),
                      loading: () => const ShimmerLoader(),
                      error: (e, _) => Text('Fehler: $e'),
                    ),
                    const SizedBox(height: 16),

                    // Water ring card
                    waterAsync.when(
                      data: (wLogs) {
                        final totalMl =
                            wLogs.fold<int>(0, (s, w) => s + w.amountMl);
                        return _WaterCard(
                          totalMl: totalMl,
                          goalMl: waterGoal,
                          onAddWater: (ml) => _addWater(context, ref, ml, totalMl),
                        );
                      },
                      loading: () => const ShimmerLoader(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 20),

                    // ── Mahlzeiten ────────────────────────────────────────────
                    SectionHeader(
                      title: 'Mahlzeiten',
                      trailing: IconButton(
                        icon: const Icon(Icons.add, color: TraumColors.cyanBlue),
                        onPressed: () => _showAddFoodDialog(context, ref),
                      ),
                    ),
                    const SizedBox(height: 8),

                    logsAsync.when(
                      data: (logs) => _MealSections(
                        logs: logs,
                        mealTypes: _mealTypes,
                        onDelete: (id) =>
                            ref.read(nutritionRepositoryProvider).deleteNutritionLog(id),
                      ),
                      loading: () => const ShimmerLoader(),
                      error: (e, _) => Text('Fehler: $e'),
                    ),
                    const SizedBox(height: 20),

                    // ── Einkaufsliste ─────────────────────────────────────────
                    SectionHeader(
                      title: 'Einkaufsliste',
                      trailing: OutlinedButton(
                        onPressed: () => context.push(Routes.shoppingList),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: TraumColors.cyanBlue,
                          side: const BorderSide(color: TraumColors.cyanBlue),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text('Öffnen'),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ]),
                ),
              ),
            ],
          ),

          // Floating bottom button
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: GradientButton(
              label: AppLocalizations.of(context).nutritionAddMeal,
              icon: Icons.add,
              onPressed: () => _showAddFoodDialog(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  static const _waterMaxMl = 10000;

  Future<void> _addWater(BuildContext context, WidgetRef ref, int ml, int totalMl) async {
    if (totalMl + ml > _waterMaxMl) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tageslimit von 10L erreicht')),
      );
      return;
    }
    await ref.read(nutritionRepositoryProvider).insertWaterLog(
          WaterLogsCompanion(logDate: Value(DateTime.now()), amountMl: Value(ml)),
        );
  }

  void _showAddFoodDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: TraumColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _AddFoodSheet(ref: ref),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Macro summary card
// ─────────────────────────────────────────────────────────────────────────────

class _MacroCard extends StatelessWidget {
  const _MacroCard({
    required this.logs,
    required this.kcalGoal,
    required this.proteinGoal,
    required this.carbGoal,
  });

  final List<NutritionLog> logs;
  final int kcalGoal;
  final int proteinGoal;
  final int carbGoal;

  @override
  Widget build(BuildContext context) {
    final totalKcal = logs.fold<double>(0, (s, l) => s + l.kcal);
    final totalProtein = logs.fold<double>(0, (s, l) => s + l.proteinG);
    final totalCarbs = logs.fold<double>(0, (s, l) => s + l.carbsG);

    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _MacroRow(
              label: 'Kalorien',
              current: totalKcal.round(),
              goal: kcalGoal,
              unit: 'kcal',
              gradient: TraumColors.gradientWarm,
            ),
            const SizedBox(height: 12),
            _MacroRow(
              label: 'Protein',
              current: totalProtein.round(),
              goal: proteinGoal,
              unit: 'g',
              gradient: TraumColors.gradientCool,
            ),
            const SizedBox(height: 12),
            _MacroRow(
              label: 'Kohlenhydrate',
              current: totalCarbs.round(),
              goal: carbGoal,
              unit: 'g',
              gradient: TraumColors.gradientAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroRow extends StatelessWidget {
  const _MacroRow({
    required this.label,
    required this.current,
    required this.goal,
    required this.unit,
    required this.gradient,
  });

  final String label;
  final int current;
  final int goal;
  final String unit;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    final ratio = goal > 0 ? (current / goal).clamp(0.0, 1.0) : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: TraumColors.onBackgroundMuted,
                fontSize: 13,
              ),
            ),
            Text(
              '$current / $goal $unit',
              style: const TextStyle(
                color: TraumColors.onBackground,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        GradientProgressBar(value: ratio, gradient: gradient, height: 8),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Water card
// ─────────────────────────────────────────────────────────────────────────────

class _WaterCard extends StatelessWidget {
  const _WaterCard({
    required this.totalMl,
    required this.goalMl,
    required this.onAddWater,
  });

  final int totalMl;
  final int goalMl;
  final void Function(int ml) onAddWater;

  @override
  Widget build(BuildContext context) {
    final ratio = goalMl > 0 ? (totalMl / goalMl).clamp(0.0, 1.0) : 0.0;

    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircularProgressRing(
              value: ratio,
              centerLabel: '${(totalMl / 1000).toStringAsFixed(1)}L',
              subLabel: 'von ${(goalMl / 1000).toStringAsFixed(1)}L',
              size: 100,
              strokeWidth: 10,
              gradient: TraumColors.gradientCool,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Wasser',
                    style: TextStyle(
                      color: TraumColors.onBackground,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$totalMl ml getrunken',
                    style: const TextStyle(
                      color: TraumColors.onBackgroundMuted,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _WaterChip(ml: 200, onTap: onAddWater),
                      const SizedBox(width: 6),
                      _WaterChip(ml: 330, onTap: onAddWater),
                      const SizedBox(width: 6),
                      _WaterChip(ml: 500, onTap: onAddWater),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaterChip extends StatelessWidget {
  const _WaterChip({required this.ml, required this.onTap});
  final int ml;
  final void Function(int ml) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(ml),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: TraumColors.cyanDim,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: TraumColors.cyanBlue.withValues(alpha: 0.4)),
        ),
        child: Text(
          '+${ml}ml',
          style: const TextStyle(
            color: TraumColors.cyanBlue,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Meal sections grouped by type
// ─────────────────────────────────────────────────────────────────────────────

class _MealSections extends StatelessWidget {
  const _MealSections({
    required this.logs,
    required this.mealTypes,
    required this.onDelete,
  });

  final List<NutritionLog> logs;
  final List<({String key, String label, IconData icon})> mealTypes;
  final Future<void> Function(int id) onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: mealTypes.map((mt) {
        final entries =
            logs.where((l) => l.mealType == mt.key).toList();
        return _MealSection(
          label: mt.label,
          icon: mt.icon,
          entries: entries,
          onDelete: onDelete,
        );
      }).toList(),
    );
  }
}

class _MealSection extends StatelessWidget {
  const _MealSection({
    required this.label,
    required this.icon,
    required this.entries,
    required this.onDelete,
  });

  final String label;
  final IconData icon;
  final List<NutritionLog> entries;
  final Future<void> Function(int id) onDelete;

  @override
  Widget build(BuildContext context) {
    final totalKcal = entries.fold<double>(0, (s, e) => s + e.kcal);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TraumCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header row
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: TraumColors.coralOrange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: TraumColors.onBackground,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  if (totalKcal > 0)
                    Text(
                      '${totalKcal.round()} kcal',
                      style: const TextStyle(
                        color: TraumColors.onBackgroundMuted,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            if (entries.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
                child: Text(
                  'Keine Einträge',
                  style: const TextStyle(
                    color: TraumColors.onBackgroundSubtle,
                    fontSize: 12,
                  ),
                ),
              )
            else
              ...entries.map(
                (e) => _NutritionLogTile(entry: e, onDelete: onDelete),
              ),
          ],
        ),
      ),
    );
  }
}

class _NutritionLogTile extends StatelessWidget {
  const _NutritionLogTile({required this.entry, required this.onDelete});
  final NutritionLog entry;
  final Future<void> Function(int id) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      title: Text(
        entry.foodName,
        style: const TextStyle(color: TraumColors.onBackground, fontSize: 13),
      ),
      subtitle: Text(
        '${entry.amountGrams.round()} g',
        style: const TextStyle(color: TraumColors.onBackgroundMuted, fontSize: 11),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${entry.kcal.round()} kcal',
            style: const TextStyle(
              color: TraumColors.coralOrange,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => onDelete(entry.id),
            child: const Icon(
              Icons.close,
              size: 16,
              color: TraumColors.onBackgroundSubtle,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Add food bottom sheet
// ─────────────────────────────────────────────────────────────────────────────

class _AddFoodSheet extends StatefulWidget {
  const _AddFoodSheet({required this.ref});
  final WidgetRef ref;

  @override
  State<_AddFoodSheet> createState() => _AddFoodSheetState();
}

class _AddFoodSheetState extends State<_AddFoodSheet> {
  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _kcalCtrl = TextEditingController();
  final _proteinCtrl = TextEditingController();
  final _carbsCtrl = TextEditingController();
  String _mealType = 'snack';

  static const _mealTypes = [
    ('breakfast', 'Frühstück'),
    ('lunch', 'Mittagessen'),
    ('dinner', 'Abendessen'),
    ('snack', 'Snacks'),
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    _kcalCtrl.dispose();
    _proteinCtrl.dispose();
    _carbsCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameCtrl.text.trim();
    final amount = double.tryParse(_amountCtrl.text.replaceAll(',', '.')) ?? 100;
    final kcal = double.tryParse(_kcalCtrl.text.replaceAll(',', '.')) ?? 0;
    final protein = double.tryParse(_proteinCtrl.text.replaceAll(',', '.')) ?? 0;
    final carbs = double.tryParse(_carbsCtrl.text.replaceAll(',', '.')) ?? 0;

    if (name.isEmpty) return;

    await widget.ref.read(nutritionRepositoryProvider).insertNutritionLog(
          NutritionLogsCompanion(
            logDate: Value(DateTime.now()),
            mealType: Value(_mealType),
            foodName: Value(name),
            amountGrams: Value(amount),
            kcal: Value(kcal),
            proteinG: Value(protein),
            carbsG: Value(carbs),
          ),
        );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 20 + pad),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lebensmittel hinzufügen',
            style: TextStyle(
              color: TraumColors.onBackground,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Meal type chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _mealTypes.map((mt) {
                final selected = _mealType == mt.$1;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(mt.$2),
                    selected: selected,
                    onSelected: (_) => setState(() => _mealType = mt.$1),
                    selectedColor: TraumColors.coralOrange,
                    backgroundColor: TraumColors.surfaceVariant,
                    labelStyle: TextStyle(
                      color: selected
                          ? Colors.white
                          : TraumColors.onBackgroundMuted,
                      fontSize: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide.none,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),

          _SheetField(controller: _nameCtrl, label: 'Lebensmittel', hint: 'z. B. Haferflocken'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: _SheetField(
                      controller: _amountCtrl,
                      label: 'Menge (g)',
                      hint: '100',
                      numeric: true)),
              const SizedBox(width: 8),
              Expanded(
                  child: _SheetField(
                      controller: _kcalCtrl,
                      label: 'Kalorien',
                      hint: 'kcal',
                      numeric: true)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: _SheetField(
                      controller: _proteinCtrl,
                      label: 'Protein (g)',
                      hint: '0',
                      numeric: true)),
              const SizedBox(width: 8),
              Expanded(
                  child: _SheetField(
                      controller: _carbsCtrl,
                      label: 'Kohlenhydrate (g)',
                      hint: '0',
                      numeric: true)),
            ],
          ),
          const SizedBox(height: 16),
          GradientButton(label: 'Eintragen', onPressed: _save),
        ],
      ),
    );
  }
}

class _SheetField extends StatelessWidget {
  const _SheetField({
    required this.controller,
    required this.label,
    required this.hint,
    this.numeric = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool numeric;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: numeric
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle:
            const TextStyle(color: TraumColors.onBackgroundMuted, fontSize: 12),
        hintStyle:
            const TextStyle(color: TraumColors.onBackgroundSubtle, fontSize: 13),
        filled: true,
        fillColor: TraumColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        isDense: true,
      ),
      style: const TextStyle(color: TraumColors.onBackground, fontSize: 14),
    );
  }
}
