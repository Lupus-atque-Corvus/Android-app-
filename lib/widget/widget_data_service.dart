import 'package:home_widget/home_widget.dart';

/// Writes all widget data keys via HomeWidget so Android/iOS home-screen
/// widgets can read the latest values from SharedPreferences / AppGroup.
class WidgetDataService {
  static const _appGroupId = 'group.de.traum.widgets';
  static const _qualifiedName = 'de.traum.traum';

  static Future<void> init() async {
    await HomeWidget.setAppGroupId(_appGroupId);
  }

  /// Push a fresh snapshot of all widget-relevant data to the platform layer
  /// and request a widget refresh for every registered widget class.
  static Future<void> updateAll({
    // Steps / activity
    int steps = 0,
    int stepsGoal = 10000,
    double calories = 0,
    double caloriesGoal = 2000,
    // Water
    int waterMl = 0,
    int waterGoalMl = 2000,
    // Nutrition
    double kcal = 0,
    double kcalGoal = 2000,
    double protein = 0,
    double proteinGoal = 150,
    // Sleep
    double sleepHours = 0,
    // Todos (next due title)
    String nextTodo = '',
    // Abstinence
    String abstinenceTitle = '',
    String abstinenceDuration = '',
    // Period
    String periodDaysLabel = '',
    // Budget
    double budgetSpent = 0,
    double budgetLimit = 0,
    // Habits completed today
    int habitsCompleted = 0,
    int habitsTotal = 0,
    // Medication taken today
    int medsTaken = 0,
    int medsTotal = 0,
    // Calendar next event
    String nextAppointment = '',
    // Health
    int heartRate = 0,
    String mood = '',
  }) async {
    final futures = <Future>[
      HomeWidget.saveWidgetData('steps', steps),
      HomeWidget.saveWidgetData('stepsGoal', stepsGoal),
      HomeWidget.saveWidgetData('calories', calories.toStringAsFixed(0)),
      HomeWidget.saveWidgetData('caloriesGoal', caloriesGoal.toStringAsFixed(0)),
      HomeWidget.saveWidgetData('waterMl', waterMl),
      HomeWidget.saveWidgetData('waterGoalMl', waterGoalMl),
      HomeWidget.saveWidgetData('kcal', kcal.toStringAsFixed(0)),
      HomeWidget.saveWidgetData('kcalGoal', kcalGoal.toStringAsFixed(0)),
      HomeWidget.saveWidgetData('protein', protein.toStringAsFixed(1)),
      HomeWidget.saveWidgetData('proteinGoal', proteinGoal.toStringAsFixed(0)),
      HomeWidget.saveWidgetData('sleepHours', sleepHours.toStringAsFixed(1)),
      HomeWidget.saveWidgetData('nextTodo', nextTodo),
      HomeWidget.saveWidgetData('abstinenceTitle', abstinenceTitle),
      HomeWidget.saveWidgetData('abstinenceDuration', abstinenceDuration),
      HomeWidget.saveWidgetData('periodDaysLabel', periodDaysLabel),
      HomeWidget.saveWidgetData('budgetSpent', budgetSpent.toStringAsFixed(2)),
      HomeWidget.saveWidgetData('budgetLimit', budgetLimit.toStringAsFixed(2)),
      HomeWidget.saveWidgetData('habitsCompleted', habitsCompleted),
      HomeWidget.saveWidgetData('habitsTotal', habitsTotal),
      HomeWidget.saveWidgetData('medsTaken', medsTaken),
      HomeWidget.saveWidgetData('medsTotal', medsTotal),
      HomeWidget.saveWidgetData('nextAppointment', nextAppointment),
      HomeWidget.saveWidgetData('heartRate', heartRate),
      HomeWidget.saveWidgetData('mood', mood),
    ];
    await Future.wait(futures);

    // Request update for every widget provider
    for (final name in _androidProviders) {
      await HomeWidget.updateWidget(
        androidName: name,
        qualifiedAndroidName: '$_qualifiedName.$name',
        iOSName: name,
      );
    }
  }

  static const _androidProviders = [
    'TraumOverviewWidgetProvider',
    'TraumTodoWidgetProvider',
    'TraumStepsWidgetProvider',
    'TraumAbstinenceWidgetProvider',
    'TraumPeriodWidgetProvider',
    'TraumHealthWidgetProvider',
    'TraumCalendarWidgetProvider',
    'TraumBudgetWidgetProvider',
    'TraumNutritionWidgetProvider',
    'TraumHabitsWidgetProvider',
    'TraumMedicationWidgetProvider',
  ];
}
