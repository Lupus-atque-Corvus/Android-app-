import 'package:shared_preferences/shared_preferences.dart';

/// Typed wrapper for all notification-related SharedPreferences keys.
class NotificationPrefs {
  NotificationPrefs(this._prefs);
  final SharedPreferences _prefs;

  // ── Medication ─────────────────────────────────────────────────────────────
  bool get medicationEnabled => _prefs.getBool('notif_medication') ?? true;
  Future<void> setMedicationEnabled(bool v) => _prefs.setBool('notif_medication', v);

  String get medicationTime => _prefs.getString('notif_medication_time') ?? '08:00';
  Future<void> setMedicationTime(String t) => _prefs.setString('notif_medication_time', t);

  // ── Supplement ─────────────────────────────────────────────────────────────
  bool get supplementEnabled => _prefs.getBool('notif_supplement') ?? true;
  Future<void> setSupplementEnabled(bool v) => _prefs.setBool('notif_supplement', v);

  String get supplementTime => _prefs.getString('notif_supplement_time') ?? '09:00';
  Future<void> setSupplementTime(String t) => _prefs.setString('notif_supplement_time', t);

  // ── Workout ────────────────────────────────────────────────────────────────
  bool get workoutEnabled => _prefs.getBool('notif_workout') ?? false;
  Future<void> setWorkoutEnabled(bool v) => _prefs.setBool('notif_workout', v);

  String get workoutTime => _prefs.getString('notif_workout_time') ?? '18:00';
  Future<void> setWorkoutTime(String t) => _prefs.setString('notif_workout_time', t);

  // ── Water ──────────────────────────────────────────────────────────────────
  bool get waterEnabled => _prefs.getBool('notif_water') ?? true;
  Future<void> setWaterEnabled(bool v) => _prefs.setBool('notif_water', v);

  int get waterIntervalMinutes => _prefs.getInt('notif_water_interval') ?? 90;
  Future<void> setWaterIntervalMinutes(int v) => _prefs.setInt('notif_water_interval', v);

  // ── Habit ──────────────────────────────────────────────────────────────────
  bool get habitEnabled => _prefs.getBool('notif_habit') ?? true;
  Future<void> setHabitEnabled(bool v) => _prefs.setBool('notif_habit', v);

  String get habitTime => _prefs.getString('notif_habit_time') ?? '20:00';
  Future<void> setHabitTime(String t) => _prefs.setString('notif_habit_time', t);

  // ── Todo ───────────────────────────────────────────────────────────────────
  bool get todoEnabled => _prefs.getBool('notif_todo') ?? true;
  Future<void> setTodoEnabled(bool v) => _prefs.setBool('notif_todo', v);

  String get todoTime => _prefs.getString('notif_todo_time') ?? '07:00';
  Future<void> setTodoTime(String t) => _prefs.setString('notif_todo_time', t);

  // ── Period ─────────────────────────────────────────────────────────────────
  bool get periodEnabled => _prefs.getBool('notif_period') ?? true;
  Future<void> setPeriodEnabled(bool v) => _prefs.setBool('notif_period', v);

  int get periodReminderDaysBefore => _prefs.getInt('notif_period_days') ?? 3;
  Future<void> setPeriodReminderDaysBefore(int v) => _prefs.setInt('notif_period_days', v);

  // ── Budget ─────────────────────────────────────────────────────────────────
  bool get budgetEnabled => _prefs.getBool('notif_budget') ?? true;
  Future<void> setBudgetEnabled(bool v) => _prefs.setBool('notif_budget', v);

  double get budgetAlertThreshold => _prefs.getDouble('notif_budget_threshold') ?? 0.9;
  Future<void> setBudgetAlertThreshold(double v) => _prefs.setDouble('notif_budget_threshold', v);
}
