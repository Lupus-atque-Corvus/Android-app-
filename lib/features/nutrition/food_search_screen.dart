import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

class FoodSearchScreen extends ConsumerStatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  ConsumerState<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends ConsumerState<FoodSearchScreen> {
  static const _foods = [
    ('Banane', 89.0, 1.1, 23.0, 0.3),
    ('Apfel', 52.0, 0.3, 14.0, 0.2),
    ('Hühnerbrust (100g)', 165.0, 31.0, 0.0, 3.6),
    ('Ei', 78.0, 6.0, 0.6, 5.0),
    ('Vollkornbrot (1 Scheibe)', 69.0, 3.0, 12.0, 1.0),
    ('Haferflocken (100g)', 389.0, 17.0, 66.0, 7.0),
    ('Milch (200ml)', 122.0, 6.6, 9.6, 6.6),
    ('Joghurt (150g)', 95.0, 8.4, 6.0, 3.5),
    ('Käse (30g)', 112.0, 7.5, 0.4, 9.0),
    ('Lachs (100g)', 208.0, 20.0, 0.0, 13.0),
    ('Reis (100g, roh)', 362.0, 7.0, 80.0, 0.7),
    ('Nudeln (100g, roh)', 358.0, 13.0, 70.0, 1.8),
    ('Kartoffel (100g)', 77.0, 2.0, 17.0, 0.1),
    ('Nüsse (30g)', 183.0, 4.4, 6.6, 17.0),
    ('Schokolade (30g)', 160.0, 2.0, 18.0, 9.0),
  ];

  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      setState(() => _query = _searchCtrl.text.toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<(String, double, double, double, double)> get _filtered {
    if (_query.isEmpty) return _foods;
    return _foods
        .where((f) => f.$1.toLowerCase().contains(_query))
        .toList();
  }

  Future<void> _addFood(
    String name,
    double kcal,
    double protein,
    double carbs,
    double fat,
  ) async {
    await ref.read(nutritionRepositoryProvider).insertNutritionLog(
          NutritionLogsCompanion(
            logDate: Value(DateTime.now()),
            mealType: const Value('Snack'),
            foodName: Value(name),
            amountGrams: const Value(100),
            kcal: Value(kcal),
            proteinG: Value(protein),
            carbsG: Value(carbs),
            fatG: Value(fat),
          ),
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hinzugefügt'),
          backgroundColor: TraumColors.success,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lebensmittel suchen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              style: const TextStyle(
                  color: TraumColors.onBackground, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Suchen…',
                hintStyle: const TextStyle(
                    color: TraumColors.onBackgroundMuted, fontSize: 14),
                prefixIcon: const Icon(Icons.search,
                    color: TraumColors.onBackgroundMuted, size: 20),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear,
                            color: TraumColors.onBackgroundMuted, size: 18),
                        onPressed: () => _searchCtrl.clear(),
                      )
                    : null,
                filled: true,
                fillColor: TraumColors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                isDense: true,
              ),
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Text(
                      'Keine Ergebnisse',
                      style: TextStyle(
                          color: TraumColors.onBackgroundMuted, fontSize: 14),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    itemCount: results.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                    itemBuilder: (context, i) {
                      final (name, kcal, protein, carbs, fat) = results[i];
                      return TraumCard(
                        child: ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 4),
                          title: Text(
                            name,
                            style: const TextStyle(
                                color: TraumColors.onBackground, fontSize: 13),
                          ),
                          subtitle: Text(
                            '${kcal.toInt()} kcal | '
                            'P: ${protein}g | '
                            'K: ${carbs}g | '
                            'F: ${fat}g',
                            style: const TextStyle(
                                color: TraumColors.onBackgroundMuted,
                                fontSize: 11),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: TraumColors.coralOrange,
                              size: 22,
                            ),
                            onPressed: () =>
                                _addFood(name, kcal, protein, carbs, fat),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
