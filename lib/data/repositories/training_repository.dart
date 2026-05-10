import '../database/traum_database.dart';
import '../database/daos/training_dao.dart';

class TrainingRepository {
  TrainingRepository(this._dao);

  final TrainingDao _dao;

  // WorkoutPlans
  Stream<List<WorkoutPlan>> watchPlans() => _dao.watchPlans();

  Stream<WorkoutPlan?> watchActivePlan() => _dao.watchActivePlan();

  Future<int> insertPlan(WorkoutPlansCompanion entry) =>
      _dao.insertPlan(entry);

  Future<bool> updatePlan(WorkoutPlan entry) => _dao.updatePlan(entry);

  Future<int> deletePlan(int id) => _dao.deletePlan(id);

  // WorkoutDays
  Stream<List<WorkoutDay>> watchDaysForPlan(int planId) =>
      _dao.watchDaysForPlan(planId);

  Future<int> insertDay(WorkoutDaysCompanion entry) => _dao.insertDay(entry);

  // Exercises
  Stream<List<Exercise>> watchExercises({String? muscleGroup}) =>
      _dao.watchExercises(muscleGroup: muscleGroup);

  Future<int> insertExercise(ExercisesCompanion entry) =>
      _dao.insertExercise(entry);

  Future<bool> updateExercise(Exercise entry) => _dao.updateExercise(entry);

  Future<int> deleteExercise(int id) => _dao.deleteExercise(id);

  // WorkoutSessions
  Stream<List<WorkoutSession>> watchSessions({int? limit}) =>
      _dao.watchSessions(limit: limit);

  Future<int> insertSession(WorkoutSessionsCompanion entry) =>
      _dao.insertSession(entry);

  Future<bool> updateSession(WorkoutSession entry) =>
      _dao.updateSession(entry);

  // WorkoutSets
  Stream<List<WorkoutSet>> watchSetsForSession(int sessionId) =>
      _dao.watchSetsForSession(sessionId);

  Future<int> insertSet(WorkoutSetsCompanion entry) => _dao.insertSet(entry);

  Future<bool> updateSet(WorkoutSet entry) => _dao.updateSet(entry);

  Future<int> deleteSet(int id) => _dao.deleteSet(id);
}
