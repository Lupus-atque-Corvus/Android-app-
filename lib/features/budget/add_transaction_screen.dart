import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show Value;
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Stream providers shared within this file
// ─────────────────────────────────────────────────────────────────────────────

final _addTxnCategoriesProvider =
    StreamProvider.autoDispose<List<BudgetCategory>>(
  (ref) => ref.watch(budgetRepositoryProvider).watchCategories(),
);

// ─────────────────────────────────────────────────────────────────────────────
// AddTransactionScreen
// ─────────────────────────────────────────────────────────────────────────────

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState
    extends ConsumerState<AddTransactionScreen> {
  final _descCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  String _type = 'expense'; // 'expense' | 'income'
  BudgetCategory? _selectedCategory;
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _descCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save(List<BudgetCategory> categories) async {
    final desc = _descCtrl.text.trim();
    final amount = double.tryParse(
        _amountCtrl.text.trim().replaceAll(',', '.'));

    if (desc.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte Beschreibung und gültigen Betrag eingeben.'),
          backgroundColor: TraumColors.error,
        ),
      );
      return;
    }

    await ref.read(budgetRepositoryProvider).insertTransaction(
          TransactionsCompanion(
            description: Value(desc),
            amount: Value(amount),
            type: Value(_type),
            date: Value(_date),
            categoryId: _selectedCategory != null
                ? Value(_selectedCategory!.id)
                : const Value.absent(),
          ),
        );

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(_addTxnCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaktion hinzufügen'),
      ),
      body: categoriesAsync.when(
        data: (categories) => _buildForm(categories),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Fehler: $e')),
      ),
    );
  }

  Widget _buildForm(List<BudgetCategory> categories) {
    final d = _date;
    final dateStr =
        '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // ── Type toggle ─────────────────────────────────────────────
        Center(
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                value: 'expense',
                label: Text('Ausgabe'),
                icon: Icon(Icons.arrow_upward),
              ),
              ButtonSegment(
                value: 'income',
                label: Text('Einnahme'),
                icon: Icon(Icons.arrow_downward),
              ),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.first),
          ),
        ),
        const SizedBox(height: 24),

        // ── Beschreibung ────────────────────────────────────────────
        TextField(
          controller: _descCtrl,
          style: const TextStyle(color: TraumColors.onBackground),
          decoration: InputDecoration(
            labelText: 'Beschreibung',
            labelStyle:
                const TextStyle(color: TraumColors.onBackgroundMuted),
            filled: true,
            fillColor: TraumColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── Betrag ──────────────────────────────────────────────────
        TextField(
          controller: _amountCtrl,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(color: TraumColors.onBackground),
          decoration: InputDecoration(
            labelText: 'Betrag',
            labelStyle:
                const TextStyle(color: TraumColors.onBackgroundMuted),
            filled: true,
            fillColor: TraumColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ── Kategorie ───────────────────────────────────────────────
        if (categories.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: TraumColors.surfaceVariant,
              borderRadius: BorderRadius.circular(14),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<BudgetCategory?>(
                value: _selectedCategory,
                dropdownColor: TraumColors.surface,
                hint: const Text('Kategorie wählen',
                    style: TextStyle(color: TraumColors.onBackgroundMuted)),
                isExpanded: true,
                items: [
                  const DropdownMenuItem<BudgetCategory?>(
                    value: null,
                    child: Text('Keine Kategorie',
                        style:
                            TextStyle(color: TraumColors.onBackgroundMuted)),
                  ),
                  ...categories.map(
                    (c) => DropdownMenuItem<BudgetCategory?>(
                      value: c,
                      child: Text(
                        '${c.emoji ?? ''} ${c.name}'.trim(),
                        style: const TextStyle(
                            color: TraumColors.onBackground),
                      ),
                    ),
                  ),
                ],
                onChanged: (v) =>
                    setState(() => _selectedCategory = v),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // ── Date picker tile ────────────────────────────────────────
        ListTile(
          onTap: _pickDate,
          tileColor: TraumColors.surfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          leading: const Icon(Icons.calendar_today,
              color: TraumColors.cyanBlue),
          title: Text(
            dateStr,
            style: const TextStyle(color: TraumColors.onBackground),
          ),
          trailing: const Icon(Icons.chevron_right,
              color: TraumColors.onBackgroundMuted),
        ),
        const SizedBox(height: 32),

        // ── Save button ─────────────────────────────────────────────
        GradientButton(
          label: 'Speichern',
          onPressed: () => _save(categories),
          icon: Icons.check,
        ),
      ],
    );
  }
}
