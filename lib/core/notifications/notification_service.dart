import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
}
