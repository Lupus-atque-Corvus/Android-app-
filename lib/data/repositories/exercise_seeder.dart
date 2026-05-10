import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/traum_database.dart';

class ExerciseSeeder {
  static const _seededKey = 'exercises_seeded_v1';

  static const _assetFiles = [
    'assets/exercises/chest.json',
    'assets/exercises/back.json',
    'assets/exercises/shoulders.json',
    'assets/exercises/biceps.json',
    'assets/exercises/triceps.json',
    'assets/exercises/legs.json',
    'assets/exercises/core.json',
    'assets/exercises/cardio.json',
    'assets/exercises/full_body.json',
  ];

  static Future<void> seedIfNeeded(TraumDatabase db) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_seededKey) == true) return;

    for (final assetPath in _assetFiles) {
      final jsonStr = await rootBundle.loadString(assetPath);
      final List<dynamic> list = json.decode(jsonStr);
      for (final item in list) {
        await db.into(db.exercises).insertOnConflictUpdate(
              ExercisesCompanion.insert(
                name: item['name'] as String,
                muscleGroup: item['muscleGroup'] as String,
                equipment: Value(item['equipment'] as String?),
                instructions: Value(item['instructions'] as String?),
                isCustom: const Value(false),
              ),
            );
      }
    }

    await prefs.setBool(_seededKey, true);
  }
}
