import 'package:shared_preferences/shared_preferences.dart';

class MedicationSeeder {
  static const _seededKey = 'medications_seeded_v1';

  static Future<void> seedIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_seededKey) == true) return;
    // No pre-seeded medications — users add their own
    await prefs.setBool(_seededKey, true);
  }
}
