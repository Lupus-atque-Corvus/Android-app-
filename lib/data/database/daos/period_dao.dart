import 'package:drift/drift.dart';
import '../traum_database.dart';

part 'period_dao.g.dart';

@DriftAccessor(tables: [PeriodEntries, CycleCalculations, PeriodSymptoms])
class PeriodDao extends DatabaseAccessor<TraumDatabase> with _$PeriodDaoMixin {
  PeriodDao(super.db);

  // PeriodEntries
  Stream<List<PeriodEntry>> watchPeriodEntries({int limit = 24}) =>
      (select(periodEntries)
            ..orderBy([(t) => OrderingTerm.desc(t.startDate)])
            ..limit(limit))
          .watch();

  Future<PeriodEntry?> getLatestPeriodEntry() =>
      (select(periodEntries)
            ..orderBy([(t) => OrderingTerm.desc(t.startDate)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertPeriodEntry(PeriodEntriesCompanion entry) =>
      into(periodEntries).insert(entry);

  Future<bool> updatePeriodEntry(PeriodEntry entry) =>
      update(periodEntries).replace(entry);

  Future<int> deletePeriodEntry(int id) =>
      (delete(periodEntries)..where((t) => t.id.equals(id))).go();

  // CycleCalculations
  Stream<List<CycleCalculation>> watchCycleCalculations({int limit = 12}) =>
      (select(cycleCalculations)
            ..orderBy([(t) => OrderingTerm.desc(t.id)])
            ..limit(limit))
          .watch();

  Future<CycleCalculation?> getLatestCycleCalculation() =>
      (select(cycleCalculations)
            ..orderBy([(t) => OrderingTerm.desc(t.id)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertCycleCalculation(CycleCalculationsCompanion entry) =>
      into(cycleCalculations).insert(entry);

  // PeriodSymptoms
  Stream<List<PeriodSymptom>> watchSymptomsForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return (select(periodSymptoms)
          ..where((t) =>
              t.logDate.isBiggerOrEqualValue(start) &
              t.logDate.isSmallerThanValue(end)))
        .watch();
  }

  Future<int> insertSymptom(PeriodSymptomsCompanion entry) =>
      into(periodSymptoms).insert(entry);

  Future<int> deleteSymptom(int id) =>
      (delete(periodSymptoms)..where((t) => t.id.equals(id))).go();
}
