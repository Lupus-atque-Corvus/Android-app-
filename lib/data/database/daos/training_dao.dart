import 'package:drift/drift.dart';
import '../traum_database.dart';

part 'training_dao.g.dart';

@DriftAccessor(tables: [WorkoutPlans, WorkoutDays, Exercises, WorkoutSessions, WorkoutSets])
class TrainingDao extends DatabaseAccessor<TraumDatabase>
    with _$TrainingDaoMixin {
  TrainingDao(super.db);

  // WorkoutPlans
  Stream<List<WorkoutPlan>> watchPlans() => select(workoutPlans).watch();

  Stream<WorkoutPlan?> watchActivePlan() =>
      (select(workoutPlans)..where((t) => t.isActive.equals(true)))
          .watchSingleOrNull();

  Future<int> insertPlan(WorkoutPlansCompanion entry) =>
      into(workoutPlans).insert(entry);

  Future<bool> updatePlan(WorkoutPlan entry) =>
      update(workoutPlans).replace(entry);

  Future<int> deletePlan(int id) =>
      (delete(workoutPlans)..where((t) => t.id.equals(id))).go();

  // WorkoutDays
  Stream<List<WorkoutDay>> watchDaysForPlan(int planId) =>
      (select(workoutDays)
            ..where((t) => t.planId.equals(planId))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .watch();

  Future<int> insertDay(WorkoutDaysCompanion entry) =>
      into(workoutDays).insert(entry);

  // Exercises
  Stream<List<Exercise>> watchExercises({String? muscleGroup}) {
    final query = select(exercises);
    if (muscleGroup != null) {
      query.where((t) => t.muscleGroup.equals(muscleGroup));
    }
    query.orderBy([(t) => OrderingTerm(expression: t.name)]);
    return query.watch();
  }

  Future<int> insertExercise(ExercisesCompanion entry) =>
      into(exercises).insert(entry);

  Future<bool> updateExercise(Exercise entry) =>
      update(exercises).replace(entry);

  Future<int> deleteExercise(int id) =>
      (delete(exercises)..where((t) => t.id.equals(id))).go();

  // WorkoutSessions
  Stream<List<WorkoutSession>> watchSessions({int? limit}) {
    final query = select(workoutSessions)
      ..orderBy([(t) => OrderingTerm.desc(t.startedAt)]);
    if (limit != null) query.limit(limit);
    return query.watch();
  }

  Future<int> insertSession(WorkoutSessionsCompanion entry) =>
      into(workoutSessions).insert(entry);

  Future<bool> updateSession(WorkoutSession entry) =>
      update(workoutSessions).replace(entry);

  // WorkoutSets
  Stream<List<WorkoutSet>> watchSetsForSession(int sessionId) =>
      (select(workoutSets)
            ..where((t) => t.sessionId.equals(sessionId))
            ..orderBy([
              (t) => OrderingTerm(expression: t.exerciseId),
              (t) => OrderingTerm(expression: t.setNumber),
            ]))
          .watch();

  Future<int> insertSet(WorkoutSetsCompanion entry) =>
      into(workoutSets).insert(entry);

  Future<bool> updateSet(WorkoutSet entry) => update(workoutSets).replace(entry);

  Future<int> deleteSet(int id) =>
      (delete(workoutSets)..where((t) => t.id.equals(id))).go();
}
