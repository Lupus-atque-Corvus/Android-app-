import 'package:drift/drift.dart';
import '../traum_database.dart';

part 'health_dao.g.dart';

@DriftAccessor(tables: [WeightLogs, BodyMeasurements, SleepLogs, MoodLogs, PhotoLogs])
class HealthDao extends DatabaseAccessor<TraumDatabase> with _$HealthDaoMixin {
  HealthDao(super.db);

  // WeightLogs
  Stream<List<WeightLog>> watchWeightLogs({int limit = 90}) =>
      (select(weightLogs)
            ..orderBy([(t) => OrderingTerm.desc(t.logDate)])
            ..limit(limit))
          .watch();

  Future<int> insertWeightLog(WeightLogsCompanion entry) =>
      into(weightLogs).insert(entry);

  Future<int> deleteWeightLog(int id) =>
      (delete(weightLogs)..where((t) => t.id.equals(id))).go();

  // BodyMeasurements
  Stream<List<BodyMeasurement>> watchMeasurements({int limit = 30}) =>
      (select(bodyMeasurements)
            ..orderBy([(t) => OrderingTerm.desc(t.logDate)])
            ..limit(limit))
          .watch();

  Future<int> insertMeasurement(BodyMeasurementsCompanion entry) =>
      into(bodyMeasurements).insert(entry);

  // SleepLogs
  Stream<List<SleepLog>> watchSleepLogs({int limit = 30}) =>
      (select(sleepLogs)
            ..orderBy([(t) => OrderingTerm.desc(t.bedtime)])
            ..limit(limit))
          .watch();

  Future<int> insertSleepLog(SleepLogsCompanion entry) =>
      into(sleepLogs).insert(entry);

  Future<bool> updateSleepLog(SleepLog entry) =>
      update(sleepLogs).replace(entry);

  Future<int> deleteSleepLog(int id) =>
      (delete(sleepLogs)..where((t) => t.id.equals(id))).go();

  // MoodLogs
  Stream<List<MoodLog>> watchMoodLogs({int limit = 30}) =>
      (select(moodLogs)
            ..orderBy([(t) => OrderingTerm.desc(t.logDate)])
            ..limit(limit))
          .watch();

  Future<int> insertMoodLog(MoodLogsCompanion entry) =>
      into(moodLogs).insert(entry);

  // PhotoLogs
  Stream<List<PhotoLog>> watchPhotoLogs({String? category}) {
    final query = select(photoLogs);
    if (category != null) query.where((t) => t.category.equals(category));
    query.orderBy([(t) => OrderingTerm.desc(t.logDate)]);
    return query.watch();
  }

  Future<int> insertPhotoLog(PhotoLogsCompanion entry) =>
      into(photoLogs).insert(entry);

  Future<int> deletePhotoLog(int id) =>
      (delete(photoLogs)..where((t) => t.id.equals(id))).go();
}
