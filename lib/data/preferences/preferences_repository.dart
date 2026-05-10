import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  PreferencesRepository(this._prefs);

  final SharedPreferences _prefs;

  // ── User profile ────────────────────────────────────────────────────────────
  String get userName => _prefs.getString('user_name') ?? '';
  Future<void> setUserName(String v) => _prefs.setString('user_name', v);

  DateTime? get userBirthday {
    final ms = _prefs.getInt('user_birthday_ms');
    return ms != null ? DateTime.fromMillisecondsSinceEpoch(ms) : null;
  }
  Future<void> setUserBirthday(DateTime v) =>
      _prefs.setInt('user_birthday_ms', v.millisecondsSinceEpoch);

  /// 'male' | 'female' | 'other'
  String get userBiologicalSex => _prefs.getString('user_biological_sex') ?? 'other';
  Future<void> setUserBiologicalSex(String v) =>
      _prefs.setString('user_biological_sex', v);

  // ── Units ───────────────────────────────────────────────────────────────────
  /// 'metric' | 'imperial'
  String get unitSystem => _prefs.getString('unit_system') ?? 'metric';
  Future<void> setUnitSystem(String v) => _prefs.setString('unit_system', v);

  // ── Theme ───────────────────────────────────────────────────────────────────
  /// 'dark' | 'light' | 'system'
  String get appTheme => _prefs.getString('app_theme') ?? 'dark';
  Future<void> setAppTheme(String v) => _prefs.setString('app_theme', v);

  // ── Locale ──────────────────────────────────────────────────────────────────
  String? get appLocale => _prefs.getString('app_locale');
  Future<void> setAppLocale(String v) => _prefs.setString('app_locale', v);
  Future<void> clearAppLocale() => _prefs.remove('app_locale');

  // ── Navigation slots ────────────────────────────────────────────────────────
  /// JSON list of 5 module keys
  String get navSlots =>
      _prefs.getString('nav_slots') ?? '["home","training","health","nutrition","planning"]';
  Future<void> setNavSlots(String json) => _prefs.setString('nav_slots', json);

  // ── Onboarding ──────────────────────────────────────────────────────────────
  bool get onboardingComplete => _prefs.getBool('onboarding_complete') ?? false;
  Future<void> setOnboardingComplete(bool v) =>
      _prefs.setBool('onboarding_complete', v);

  // ── Goals ───────────────────────────────────────────────────────────────────
  int get stepsGoal => _prefs.getInt('steps_goal') ?? 10000;
  Future<void> setStepsGoal(int v) => _prefs.setInt('steps_goal', v);

  double get weightGoalKg => _prefs.getDouble('weight_goal_kg') ?? 75.0;
  Future<void> setWeightGoalKg(double v) => _prefs.setDouble('weight_goal_kg', v);

  double get heightCm => _prefs.getDouble('height_cm') ?? 175.0;
  Future<void> setHeightCm(double v) => _prefs.setDouble('height_cm', v);

  int get kcalGoal => _prefs.getInt('kcal_goal') ?? 2000;
  Future<void> setKcalGoal(int v) => _prefs.setInt('kcal_goal', v);

  int get proteinGoalG => _prefs.getInt('protein_goal_g') ?? 150;
  Future<void> setProteinGoalG(int v) => _prefs.setInt('protein_goal_g', v);

  int get waterGoalMl => _prefs.getInt('water_goal_ml') ?? 2500;
  Future<void> setWaterGoalMl(int v) => _prefs.setInt('water_goal_ml', v);

  // ── Period tracking ─────────────────────────────────────────────────────────
  bool get isPeriodTrackingEnabled =>
      _prefs.getBool('period_tracking_enabled') ??
      (userBiologicalSex == 'female');
  Future<void> setIsPeriodTrackingEnabled(bool v) =>
      _prefs.setBool('period_tracking_enabled', v);

  int get avgCycleLength => _prefs.getInt('avg_cycle_length') ?? 28;
  Future<void> setAvgCycleLength(int v) => _prefs.setInt('avg_cycle_length', v);

  int get avgPeriodLength => _prefs.getInt('avg_period_length') ?? 5;
  Future<void> setAvgPeriodLength(int v) => _prefs.setInt('avg_period_length', v);

  // ── Location (for weather) ──────────────────────────────────────────────────
  double? get weatherLat => _prefs.getDouble('weather_lat');
  double? get weatherLon => _prefs.getDouble('weather_lon');
  Future<void> setWeatherLocation(double lat, double lon) async {
    await _prefs.setDouble('weather_lat', lat);
    await _prefs.setDouble('weather_lon', lon);
  }

  // ── Biometric lock ──────────────────────────────────────────────────────────
  bool get biometricLockEnabled => _prefs.getBool('biometric_lock') ?? false;
  Future<void> setBiometricLockEnabled(bool v) =>
      _prefs.setBool('biometric_lock', v);

  // ── Budget ──────────────────────────────────────────────────────────────────
  String get currencySymbol => _prefs.getString('currency_symbol') ?? '€';
  Future<void> setCurrencySymbol(String v) =>
      _prefs.setString('currency_symbol', v);

  double get monthlyBudget => _prefs.getDouble('monthly_budget') ?? 1500.0;
  Future<void> setMonthlyBudget(double v) =>
      _prefs.setDouble('monthly_budget', v);

  // ── Notification toggles ────────────────────────────────────────────────────
  bool get notifMedication => _prefs.getBool('notif_medication') ?? true;
  Future<void> setNotifMedication(bool v) => _prefs.setBool('notif_medication', v);

  bool get notifSupplement => _prefs.getBool('notif_supplement') ?? true;
  Future<void> setNotifSupplement(bool v) => _prefs.setBool('notif_supplement', v);

  bool get notifWorkout => _prefs.getBool('notif_workout') ?? true;
  Future<void> setNotifWorkout(bool v) => _prefs.setBool('notif_workout', v);

  bool get notifWater => _prefs.getBool('notif_water') ?? true;
  Future<void> setNotifWater(bool v) => _prefs.setBool('notif_water', v);

  bool get notifTodo => _prefs.getBool('notif_todo') ?? true;
  Future<void> setNotifTodo(bool v) => _prefs.setBool('notif_todo', v);

  bool get notifHabit => _prefs.getBool('notif_habit') ?? true;
  Future<void> setNotifHabit(bool v) => _prefs.setBool('notif_habit', v);

  bool get notifPeriod => _prefs.getBool('notif_period') ?? true;
  Future<void> setNotifPeriod(bool v) => _prefs.setBool('notif_period', v);

  bool get notifBudget => _prefs.getBool('notif_budget') ?? false;
  Future<void> setNotifBudget(bool v) => _prefs.setBool('notif_budget', v);

  // ── Weather reminder ────────────────────────────────────────────────────────
  String get workoutReminderTime => _prefs.getString('workout_reminder_time') ?? '07:00';
  Future<void> setWorkoutReminderTime(String v) =>
      _prefs.setString('workout_reminder_time', v);

  String get waterReminderInterval =>
      _prefs.getString('water_reminder_interval') ?? '120';
  Future<void> setWaterReminderInterval(String v) =>
      _prefs.setString('water_reminder_interval', v);
}
