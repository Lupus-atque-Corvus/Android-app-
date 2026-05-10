import 'package:drift/drift.dart';
import '../traum_database.dart';

part 'supplement_dao.g.dart';

@DriftAccessor(tables: [Supplements, SupplementLogs])
class SupplementDao extends DatabaseAccessor<TraumDatabase>
    with _$SupplementDaoMixin {
  SupplementDao(super.db);

  Stream<List<Supplement>> watchSupplements({bool activeOnly = true}) {
    final query = select(supplements);
    if (activeOnly) query.where((t) => t.isActive.equals(true));
    query.orderBy([(t) => OrderingTerm(expression: t.name)]);
    return query.watch();
  }

  Future<int> insertSupplement(SupplementsCompanion entry) =>
      into(supplements).insert(entry);

  Future<bool> updateSupplement(Supplement entry) =>
      update(supplements).replace(entry);

  Future<int> deleteSupplement(int id) =>
      (delete(supplements)..where((t) => t.id.equals(id))).go();

  Stream<List<SupplementLog>> watchLogsForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return (select(supplementLogs)
          ..where((t) =>
              t.takenAt.isBiggerOrEqualValue(start) &
              t.takenAt.isSmallerThanValue(end)))
        .watch();
  }

  Future<int> insertLog(SupplementLogsCompanion entry) =>
      into(supplementLogs).insert(entry);

  Future<int> deleteLog(int id) =>
      (delete(supplementLogs)..where((t) => t.id.equals(id))).go();
}
