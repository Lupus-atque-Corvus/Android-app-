import '../database/traum_database.dart';

class PeriodRepository {
  PeriodRepository(this._dao);
  final PeriodDao _dao;

  Stream<List<PeriodEntry>> watchPeriodEntries({int limit = 24}) =>
      _dao.watchPeriodEntries(limit: limit);
  Future<PeriodEntry?> getLatestPeriodEntry() => _dao.getLatestPeriodEntry();
  Future<int> insertPeriodEntry(PeriodEntriesCompanion e) =>
      _dao.insertPeriodEntry(e);
  Future<bool> updatePeriodEntry(PeriodEntry e) => _dao.updatePeriodEntry(e);
  Future<int> deletePeriodEntry(int id) => _dao.deletePeriodEntry(id);

  Stream<List<CycleCalculation>> watchCycleCalculations({int limit = 12}) =>
      _dao.watchCycleCalculations(limit: limit);
  Future<CycleCalculation?> getLatestCycleCalculation() =>
      _dao.getLatestCycleCalculation();
  Future<int> insertCycleCalculation(CycleCalculationsCompanion e) =>
      _dao.insertCycleCalculation(e);

  Stream<List<PeriodSymptom>> watchSymptomsForDay(DateTime day) =>
      _dao.watchSymptomsForDay(day);
  Future<int> insertSymptom(PeriodSymptomsCompanion e) =>
      _dao.insertSymptom(e);
  Future<int> deleteSymptom(int id) => _dao.deleteSymptom(id);
}
