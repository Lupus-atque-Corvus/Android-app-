import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/traum_database.dart';

class SupplementSeeder {
  static const _seededKey = 'supplements_seeded_v1';

  static const _assetFiles = [
    'assets/supplements/vitamins.json',
    'assets/supplements/minerals.json',
    'assets/supplements/amino_acids.json',
    'assets/supplements/protein.json',
    'assets/supplements/omega.json',
    'assets/supplements/adaptogens.json',
    'assets/supplements/pre_workout.json',
    'assets/supplements/gut_health.json',
    'assets/supplements/creatine.json',
  ];

  static Future<void> seedIfNeeded(TraumDatabase db) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_seededKey) == true) return;

    for (final assetPath in _assetFiles) {
      final jsonStr = await rootBundle.loadString(assetPath);
      final List<dynamic> list = json.decode(jsonStr);
      for (final item in list) {
        final timings = item['timings'] as List<dynamic>? ?? [];
        await db.into(db.supplements).insertOnConflictUpdate(
              SupplementsCompanion.insert(
                name: item['name'] as String,
                category: Value(item['category'] as String?),
                dosageAmount: Value(item['dosageAmount'] as String?),
                dosageUnit: Value(item['dosageUnit'] as String?),
                timings: Value(json.encode(timings)),
                notes: Value(item['notes'] as String?),
                isActive: const Value(false),
              ),
            );
      }
    }

    await prefs.setBool(_seededKey, true);
  }
}
