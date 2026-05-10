import 'package:drift/drift.dart';
import '../traum_database.dart';

part 'planning_dao.g.dart';

@DriftAccessor(tables: [Appointments, Todos, Goals, SubTasks, Habits, HabitLogs])
class PlanningDao extends DatabaseAccessor<TraumDatabase>
    with _$PlanningDaoMixin {
  PlanningDao(super.db);

  // Appointments
  Stream<List<Appointment>> watchAppointments() =>
      (select(appointments)..orderBy([(t) => OrderingTerm(expression: t.startTime)])).watch();

  Stream<List<Appointment>> watchAppointmentsForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return (select(appointments)
          ..where((t) => t.startTime.isBiggerOrEqualValue(start) &
              t.startTime.isSmallerThanValue(end))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime)]))
        .watch();
  }

  Future<int> insertAppointment(AppointmentsCompanion entry) =>
      into(appointments).insert(entry);

  Future<bool> updateAppointment(Appointment entry) =>
      update(appointments).replace(entry);

  Future<int> deleteAppointment(int id) =>
      (delete(appointments)..where((t) => t.id.equals(id))).go();

  // Todos
  Stream<List<Todo>> watchTodos({bool? done}) {
    final query = select(todos);
    if (done != null) query.where((t) => t.done.equals(done));
    query.orderBy([
      (t) => OrderingTerm.desc(t.priority),
      (t) => OrderingTerm(expression: t.createdAt),
    ]);
    return query.watch();
  }

  Future<int> insertTodo(TodosCompanion entry) => into(todos).insert(entry);

  Future<bool> updateTodo(Todo entry) => update(todos).replace(entry);

  Future<int> deleteTodo(int id) =>
      (delete(todos)..where((t) => t.id.equals(id))).go();

  // Goals
  Stream<List<Goal>> watchGoals() =>
      (select(goals)..orderBy([(t) => OrderingTerm(expression: t.createdAt)])).watch();

  Future<int> insertGoal(GoalsCompanion entry) => into(goals).insert(entry);

  Future<bool> updateGoal(Goal entry) => update(goals).replace(entry);

  Future<int> deleteGoal(int id) =>
      (delete(goals)..where((t) => t.id.equals(id))).go();

  // SubTasks
  Stream<List<SubTask>> watchSubTasks(int goalId) =>
      (select(subTasks)
            ..where((t) => t.goalId.equals(goalId))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .watch();

  Future<int> insertSubTask(SubTasksCompanion entry) =>
      into(subTasks).insert(entry);

  Future<bool> updateSubTask(SubTask entry) => update(subTasks).replace(entry);

  // Habits
  Stream<List<Habit>> watchHabits() => select(habits).watch();

  Future<int> insertHabit(HabitsCompanion entry) => into(habits).insert(entry);

  Future<bool> updateHabit(Habit entry) => update(habits).replace(entry);

  Future<int> deleteHabit(int id) =>
      (delete(habits)..where((t) => t.id.equals(id))).go();

  // HabitLogs
  Stream<List<HabitLog>> watchHabitLogsForWeek(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 7));
    return (select(habitLogs)
          ..where((t) =>
              t.logDate.isBiggerOrEqualValue(weekStart) &
              t.logDate.isSmallerThanValue(weekEnd)))
        .watch();
  }

  Future<int> insertHabitLog(HabitLogsCompanion entry) =>
      into(habitLogs).insert(entry);

  Future<int> deleteHabitLog(int habitId, DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return (delete(habitLogs)
          ..where((t) =>
              t.habitId.equals(habitId) &
              t.logDate.isBiggerOrEqualValue(dayStart) &
              t.logDate.isSmallerThanValue(dayEnd)))
        .go();
  }
}
