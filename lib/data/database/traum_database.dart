import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/planning_tables.dart';
import 'tables/training_tables.dart';
import 'tables/health_tables.dart';
import 'tables/nutrition_tables.dart';
import 'tables/supplement_tables.dart';
import 'tables/medication_tables.dart';
import 'tables/abstinence_tables.dart';
import 'tables/budget_tables.dart';
import 'tables/period_tables.dart';

import 'daos/planning_dao.dart';
import 'daos/training_dao.dart';
import 'daos/health_dao.dart';
import 'daos/nutrition_dao.dart';
import 'daos/supplement_dao.dart';
import 'daos/medication_dao.dart';
import 'daos/abstinence_dao.dart';
import 'daos/budget_dao.dart';
import 'daos/period_dao.dart';

export 'tables/planning_tables.dart';
export 'tables/training_tables.dart';
export 'tables/health_tables.dart';
export 'tables/nutrition_tables.dart';
export 'tables/supplement_tables.dart';
export 'tables/medication_tables.dart';
export 'tables/abstinence_tables.dart';
export 'tables/budget_tables.dart';
export 'tables/period_tables.dart';

export 'daos/planning_dao.dart';
export 'daos/training_dao.dart';
export 'daos/health_dao.dart';
export 'daos/nutrition_dao.dart';
export 'daos/supplement_dao.dart';
export 'daos/medication_dao.dart';
export 'daos/abstinence_dao.dart';
export 'daos/budget_dao.dart';
export 'daos/period_dao.dart';

part 'traum_database.g.dart';

@DriftDatabase(
  tables: [
    // Planning
    Appointments,
    Todos,
    Goals,
    SubTasks,
    Habits,
    HabitLogs,
    // Training
    WorkoutPlans,
    WorkoutDays,
    Exercises,
    WorkoutSessions,
    WorkoutSets,
    // Health
    WeightLogs,
    BodyMeasurements,
    SleepLogs,
    MoodLogs,
    PhotoLogs,
    // Nutrition
    NutritionLogs,
    MealTemplates,
    WaterLogs,
    ShoppingListItems,
    // Supplements
    Supplements,
    SupplementLogs,
    // Medication
    Medications,
    MedicationLogs,
    // Abstinence
    AbstinenceTrackers,
    AbstinenceEvents,
    // Budget
    Transactions,
    BudgetCategories,
    SavingsGoals,
    Debts,
    // Period
    PeriodEntries,
    CycleCalculations,
    PeriodSymptoms,
  ],
  daos: [
    PlanningDao,
    TrainingDao,
    HealthDao,
    NutritionDao,
    SupplementDao,
    MedicationDao,
    AbstinenceDao,
    BudgetDao,
    PeriodDao,
  ],
)
class TraumDatabase extends _$TraumDatabase {
  TraumDatabase() : super(_openConnection());
  TraumDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'traum.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
