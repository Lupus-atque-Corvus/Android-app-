import 'package:drift/drift.dart';
import '../traum_database.dart';

part 'medication_dao.g.dart';

@DriftAccessor(tables: [Medications, MedicationLogs])
class MedicationDao extends DatabaseAccessor<TraumDatabase>
    with _$MedicationDaoMixin {
  MedicationDao(super.db);

  Stream<List<Medication>> watchMedications({bool activeOnly = true}) {
    final query = select(medications);
    if (activeOnly) query.where((t) => t.isActive.equals(true));
    query.orderBy([(t) => OrderingTerm(expression: t.name)]);
    return query.watch();
  }

  Future<int> insertMedication(MedicationsCompanion entry) =>
      into(medications).insert(entry);

  Future<bool> updateMedication(Medication entry) =>
      update(medications).replace(entry);

  Future<int> deleteMedication(int id) =>
      (delete(medications)..where((t) => t.id.equals(id))).go();

  Stream<List<MedicationLog>> watchLogsForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return (select(medicationLogs)
          ..where((t) =>
              t.scheduledAt.isBiggerOrEqualValue(start) &
              t.scheduledAt.isSmallerThanValue(end))
          ..orderBy([(t) => OrderingTerm(expression: t.scheduledAt)]))
        .watch();
  }

  Future<int> insertLog(MedicationLogsCompanion entry) =>
      into(medicationLogs).insert(entry);

  Future<bool> updateLog(MedicationLog entry) =>
      update(medicationLogs).replace(entry);
}
