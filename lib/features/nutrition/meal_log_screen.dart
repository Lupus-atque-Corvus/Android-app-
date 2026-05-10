import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show Value;
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

final _mealTemplatesProvider =
    StreamProvider.autoDispose<List<MealTemplate>>((ref) {
  return ref.watch(nutritionRepositoryProvider).watchTemplates();
});

class MealLogScreen extends ConsumerStatefulWidget {
  const MealLogScreen({super.key});

  @override
  ConsumerState<MealLogScreen> createState() => _MealLogScreenState();
}

class _MealLogScreenState extends ConsumerState<MealLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _foodNameCtrl = TextEditingController();
  final _kcalCtrl = TextEditingController();
  final _proteinCtrl = TextEditingController();
  final _carbsCtrl = TextEditingController();
  final _fatCtrl = TextEditingController();

  String _mealType = 'Frühstück';

  static const _mealTypes = [
    'Frühstück',
    'Mittagessen',
    'Abendessen',
    'Snack',
  ];

  @override
  void dispose() {
    _foodNameCtrl.dispose();
    _kcalCtrl.dispose();
    _proteinCtrl.dispose();
    _carbsCtrl.dispose();
    _fatCtrl.dispose();
    super.dispose();
  }

  void _fillFromTemplate(MealTemplate t) {
    setState(() {
      _foodNameCtrl.text = t.name;
      _kcalCtrl.text = t.kcalPer100g.toStringAsFixed(1);
      _proteinCtrl.text = t.proteinPer100g.toStringAsFixed(1);
      _carbsCtrl.text = t.carbsPer100g.toStringAsFixed(1);
      _fatCtrl.text = t.fatPer100g.toStringAsFixed(1);
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final kcal = double.tryParse(_kcalCtrl.text.replaceAll(',', '.')) ?? 0;
    final protein =
        double.tryParse(_proteinCtrl.text.replaceAll(',', '.')) ?? 0;
    final carbs = double.tryParse(_carbsCtrl.text.replaceAll(',', '.')) ?? 0;
    final fat = double.tryParse(_fatCtrl.text.replaceAll(',', '.')) ?? 0;

    await ref.read(nutritionRepositoryProvider).insertNutritionLog(
          NutritionLogsCompanion(
            logDate: Value(DateTime.now()),
            mealType: Value(_mealType),
            foodName: Value(_foodNameCtrl.text.trim()),
            amountGrams: const Value(100),
            kcal: Value(kcal),
            proteinG: Value(protein),
            carbsG: Value(carbs),
            fatG: Value(fat),
          ),
        );

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahlzeit erfassen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown(),
                const SizedBox(height: 16),
                _buildFoodNameField(),
                const SizedBox(height: 16),
                _buildMacroRow(),
                const SizedBox(height: 24),
                GradientButton(
                  label: 'Speichern',
                  icon: Icons.check,
                  onPressed: _save,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildTemplatesSection(),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: TraumColors.surfaceVariant,
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: _mealType,
          dropdownColor: TraumColors.surface,
          decoration: const InputDecoration(
            border: InputBorder.none,
            labelText: 'Mahlzeit',
            labelStyle:
                TextStyle(color: TraumColors.onBackgroundMuted, fontSize: 12),
          ),
          style: const TextStyle(color: TraumColors.onBackground, fontSize: 14),
          items: _mealTypes
              .map(
                (t) => DropdownMenuItem(
                  value: t,
                  child: Text(t),
                ),
              )
              .toList(),
          onChanged: (v) {
            if (v != null) setState(() => _mealType = v);
          },
        ),
      ),
    );
  }

  Widget _buildFoodNameField() {
    return TextFormField(
      controller: _foodNameCtrl,
      style: const TextStyle(color: TraumColors.onBackground, fontSize: 14),
      decoration: _inputDecoration('Lebensmittel', 'z. B. Haferflocken'),
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? 'Bitte Name eingeben' : null,
    );
  }

  Widget _buildMacroRow() {
    return Row(
      children: [
        Expanded(
          child: _NumField(
              controller: _kcalCtrl, label: 'Kalorien', hint: 'kcal'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _NumField(
              controller: _proteinCtrl, label: 'Protein (g)', hint: '0'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _NumField(
              controller: _carbsCtrl,
              label: 'Kohlenhydrate (g)',
              hint: '0'),
        ),
        const SizedBox(width: 8),
        Expanded(
          child:
              _NumField(controller: _fatCtrl, label: 'Fett (g)', hint: '0'),
        ),
      ],
    );
  }

  Widget _buildTemplatesSection() {
    final templatesAsync = ref.watch(_mealTemplatesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Vorlagen',
          style: TextStyle(
            color: TraumColors.onBackground,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        templatesAsync.when(
          data: (templates) {
            if (templates.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Keine Vorlagen gespeichert.',
                  style: TextStyle(
                      color: TraumColors.onBackgroundMuted, fontSize: 13),
                ),
              );
            }
            return TraumCard(
              child: Column(
                children: templates
                    .map(
                      (t) => ListTile(
                        title: Text(
                          t.name,
                          style: const TextStyle(
                              color: TraumColors.onBackground, fontSize: 13),
                        ),
                        subtitle: Text(
                          '${t.kcalPer100g.toInt()} kcal | '
                          'P: ${t.proteinPer100g}g | '
                          'K: ${t.carbsPer100g}g | '
                          'F: ${t.fatPer100g}g',
                          style: const TextStyle(
                              color: TraumColors.onBackgroundMuted,
                              fontSize: 11),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: TraumColors.onBackgroundMuted,
                        ),
                        onTap: () => _fillFromTemplate(t),
                      ),
                    )
                    .toList(),
              ),
            );
          },
          loading: () => const ShimmerLoader(),
          error: (e, _) => Text(
            'Fehler: $e',
            style: const TextStyle(color: TraumColors.error),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
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
    );
  }
}

class _NumField extends StatelessWidget {
  const _NumField({
    required this.controller,
    required this.label,
    required this.hint,
  });

  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: TraumColors.onBackground, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(
            color: TraumColors.onBackgroundMuted, fontSize: 11),
        hintStyle: const TextStyle(
            color: TraumColors.onBackgroundSubtle, fontSize: 12),
        filled: true,
        fillColor: TraumColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        isDense: true,
      ),
    );
  }
}
