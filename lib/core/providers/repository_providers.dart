import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/planning_repository.dart';
import '../../data/repositories/training_repository.dart';
import '../../data/repositories/health_repository.dart';
import '../../data/repositories/nutrition_repository.dart';
import '../../data/repositories/supplement_repository.dart';
import '../../data/repositories/medication_repository.dart';
import '../../data/repositories/abstinence_repository.dart';
import '../../data/repositories/budget_repository.dart';
import '../../data/repositories/period_repository.dart';
import '../../data/database/traum_database.dart';
import 'database_provider.dart';

final planningRepositoryProvider = Provider(
  (ref) => PlanningRepository(ref.watch(planningDaoProvider)),
);

final trainingRepositoryProvider = Provider(
  (ref) => TrainingRepository(ref.watch(trainingDaoProvider)),
);

final healthRepositoryProvider = Provider(
  (ref) => HealthRepository(ref.watch(healthDaoProvider)),
);

final nutritionRepositoryProvider = Provider(
  (ref) => NutritionRepository(ref.watch(nutritionDaoProvider)),
);

final supplementRepositoryProvider = Provider(
  (ref) => SupplementRepository(ref.watch(supplementDaoProvider)),
);

final medicationRepositoryProvider = Provider(
  (ref) => MedicationRepository(ref.watch(medicationDaoProvider)),
);

final abstinenceRepositoryProvider = Provider(
  (ref) => AbstinenceRepository(ref.watch(abstinenceDaoProvider)),
);

final budgetRepositoryProvider = Provider(
  (ref) => BudgetRepository(ref.watch(budgetDaoProvider)),
);

final periodRepositoryProvider = Provider(
  (ref) => PeriodRepository(ref.watch(periodDaoProvider)),
);

// ── Shared water provider — used by both HomeScreen and NutritionScreen ───────
final todayWaterLogsProvider = StreamProvider<List<WaterLog>>((ref) {
  return ref
      .watch(nutritionRepositoryProvider)
      .watchWaterLogsForDay(DateTime.now());
});

final todayWaterMlProvider = Provider<AsyncValue<int>>((ref) {
  return ref
      .watch(todayWaterLogsProvider)
      .whenData((logs) => logs.fold(0, (sum, l) => sum + l.amountMl));
});
