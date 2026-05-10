import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/providers/preferences_provider.dart';
import 'data/database/traum_database.dart';
import 'data/repositories/exercise_seeder.dart';
import 'data/repositories/supplement_seeder.dart';
import 'data/repositories/medication_seeder.dart';
import 'widget/widget_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final db = TraumDatabase();

  await WidgetDataService.init();

  await Future.wait([
    ExerciseSeeder.seedIfNeeded(db),
    SupplementSeeder.seedIfNeeded(db),
    MedicationSeeder.seedIfNeeded(),
  ]);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const TraumApp(),
    ),
  );
}
