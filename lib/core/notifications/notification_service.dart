import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelMedication = AndroidNotificationChannel(
    'medication_reminders',
    'Medikamenten-Erinnerungen',
    description: 'Tägliche Erinnerungen zur Medikamenteneinnahme',
    importance: Importance.high,
  );

  static const _channelSupplement = AndroidNotificationChannel(
    'supplement_reminders',
    'Supplement-Erinnerungen',
    description: 'Erinnerungen zur Supplementeinnahme',
    importance: Importance.defaultImportance,
  );

  static const _channelWorkout = AndroidNotificationChannel(
    'workout_reminders',
    'Training-Erinnerungen',
    description: 'Erinnerungen für geplante Trainingseinheiten',
    importance: Importance.defaultImportance,
  );

  static const _channelWater = AndroidNotificationChannel(
    'water_reminders',
    'Wasser-Erinnerungen',
    description: 'Regelmäßige Erinnerungen zum Trinken',
    importance: Importance.low,
  );

  static const _channelHabit = AndroidNotificationChannel(
    'habit_reminders',
    'Gewohnheits-Erinnerungen',
    description: 'Erinnerungen für Gewohnheiten',
    importance: Importance.defaultImportance,
  );

  static const _channelTodo = AndroidNotificationChannel(
    'todo_reminders',
    'Todo-Fälligkeiten',
    description: 'Erinnerungen für fällige Aufgaben',
    importance: Importance.high,
  );

  static const _channelPeriod = AndroidNotificationChannel(
    'period_reminders',
    'Zyklus-Erinnerungen',
    description: 'Vorhersagen und Erinnerungen für den Zyklus',
    importance: Importance.defaultImportance,
  );

  static const _channelBudget = AndroidNotificationChannel(
    'budget_alerts',
    'Budget-Warnungen',
    description: 'Warnungen bei Budgetüberschreitung',
    importance: Importance.high,
  );

  static Future<void> init() async {
    tz_data.initializeTimeZones();
    final String tzName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(tzName));

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
    );

    // Create Android channels
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      for (final ch in [
        _channelMedication,
        _channelSupplement,
        _channelWorkout,
        _channelWater,
        _channelHabit,
        _channelTodo,
        _channelPeriod,
        _channelBudget,
      ]) {
        await androidPlugin.createNotificationChannel(ch);
      }
    }
  }

  static Future<bool> requestPermissions() async {
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    if (ios != null) {
      return await ios.requestPermissions(alert: true, badge: true, sound: true) ?? false;
    }
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    return false;
  }

  static Future<void> showImmediate({
    required int id,
    required String title,
    required String body,
    String channelId = 'medication_reminders',
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(channelId, channelId, importance: Importance.high),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }

  static Future<void> cancelAll() => _plugin.cancelAll();

  static Future<void> cancel(int id) => _plugin.cancel(id);

  /// Schedule a daily notification at the given hour:minute.
  /// [id] must be unique per logical notification slot.
  static Future<void> scheduleDailyAt({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    String channelId = 'medication_reminders',
  }) async {
    await _plugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute),
      NotificationDetails(
        android: AndroidNotificationDetails(channelId, channelId, importance: Importance.high),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  /// Cancel all scheduled notifications and re-register all enabled ones
  /// based on the provided [prefs]. Call this whenever notification settings change.
  static Future<void> rescheduleAll(NotificationPrefsSnapshot prefs) async {
    await cancelAll();

    if (prefs.medicationEnabled) {
      await scheduleDailyAt(
        id: 100,
        title: 'Medikament einnehmen',
        body: 'Zeit für deine Medikamente.',
        hour: prefs.medicationHour,
        minute: prefs.medicationMinute,
        channelId: 'medication_reminders',
      );
    }
    if (prefs.supplementEnabled) {
      await scheduleDailyAt(
        id: 101,
        title: 'Supplements einnehmen',
        body: 'Vergiss deine täglichen Supplements nicht.',
        hour: prefs.supplementHour,
        minute: prefs.supplementMinute,
        channelId: 'supplement_reminders',
      );
    }
    if (prefs.workoutEnabled) {
      await scheduleDailyAt(
        id: 102,
        title: 'Training heute?',
        body: 'Zeit für dein geplantes Training.',
        hour: prefs.workoutHour,
        minute: prefs.workoutMinute,
        channelId: 'workout_reminders',
      );
    }
    if (prefs.habitEnabled) {
      await scheduleDailyAt(
        id: 103,
        title: 'Gewohnheiten checken',
        body: 'Hast du heute alle Gewohnheiten erledigt?',
        hour: prefs.habitHour,
        minute: prefs.habitMinute,
        channelId: 'habit_reminders',
      );
    }
    if (prefs.todoEnabled) {
      await scheduleDailyAt(
        id: 104,
        title: 'Aufgaben für heute',
        body: 'Überprüfe deine heutigen To-dos.',
        hour: prefs.todoHour,
        minute: prefs.todoMinute,
        channelId: 'todo_reminders',
      );
    }
  }
}

/// Immutable snapshot of notification preferences, passed to rescheduleAll.
class NotificationPrefsSnapshot {
  const NotificationPrefsSnapshot({
    this.medicationEnabled = true,
    this.medicationHour = 8,
    this.medicationMinute = 0,
    this.supplementEnabled = true,
    this.supplementHour = 9,
    this.supplementMinute = 0,
    this.workoutEnabled = false,
    this.workoutHour = 18,
    this.workoutMinute = 0,
    this.habitEnabled = true,
    this.habitHour = 20,
    this.habitMinute = 0,
    this.todoEnabled = true,
    this.todoHour = 7,
    this.todoMinute = 0,
  });

  final bool medicationEnabled;
  final int medicationHour;
  final int medicationMinute;
  final bool supplementEnabled;
  final int supplementHour;
  final int supplementMinute;
  final bool workoutEnabled;
  final int workoutHour;
  final int workoutMinute;
  final bool habitEnabled;
  final int habitHour;
  final int habitMinute;
  final bool todoEnabled;
  final int todoHour;
  final int todoMinute;
}
