import '../database/traum_database.dart';

class PlanningRepository {
  PlanningRepository(this._dao);
  final PlanningDao _dao;

  Stream<List<Appointment>> watchAppointments() => _dao.watchAppointments();
  Stream<List<Appointment>> watchAppointmentsForDay(DateTime day) =>
      _dao.watchAppointmentsForDay(day);
  Future<int> insertAppointment(AppointmentsCompanion e) =>
      _dao.insertAppointment(e);
  Future<bool> updateAppointment(Appointment e) => _dao.updateAppointment(e);
  Future<int> deleteAppointment(int id) => _dao.deleteAppointment(id);

  Stream<List<Todo>> watchTodos({bool? done}) => _dao.watchTodos(done: done);
  Future<int> insertTodo(TodosCompanion e) => _dao.insertTodo(e);
  Future<bool> updateTodo(Todo e) => _dao.updateTodo(e);
  Future<int> deleteTodo(int id) => _dao.deleteTodo(id);

  Stream<List<Goal>> watchGoals() => _dao.watchGoals();
  Future<int> insertGoal(GoalsCompanion e) => _dao.insertGoal(e);
  Future<bool> updateGoal(Goal e) => _dao.updateGoal(e);
  Future<int> deleteGoal(int id) => _dao.deleteGoal(id);

  Stream<List<SubTask>> watchSubTasks(int goalId) =>
      _dao.watchSubTasks(goalId);
  Future<int> insertSubTask(SubTasksCompanion e) => _dao.insertSubTask(e);
  Future<bool> updateSubTask(SubTask e) => _dao.updateSubTask(e);

  Stream<List<Habit>> watchHabits() => _dao.watchHabits();
  Future<int> insertHabit(HabitsCompanion e) => _dao.insertHabit(e);
  Future<bool> updateHabit(Habit e) => _dao.updateHabit(e);
  Future<int> deleteHabit(int id) => _dao.deleteHabit(id);

  Stream<List<HabitLog>> watchHabitLogsForWeek(DateTime weekStart) =>
      _dao.watchHabitLogsForWeek(weekStart);
  Future<int> insertHabitLog(HabitLogsCompanion e) => _dao.insertHabitLog(e);
  Future<int> deleteHabitLog(int habitId, DateTime date) =>
      _dao.deleteHabitLog(habitId, date);
}
