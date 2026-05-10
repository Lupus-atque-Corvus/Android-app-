import '../database/traum_database.dart';

class HealthRepository {
  HealthRepository(this._dao);
  final HealthDao _dao;

  Stream<List<WeightLog>> watchWeightLogs({int limit = 90}) =>
      _dao.watchWeightLogs(limit: limit);
  Future<int> insertWeightLog(WeightLogsCompanion e) =>
      _dao.insertWeightLog(e);
  Future<int> deleteWeightLog(int id) => _dao.deleteWeightLog(id);

  Stream<List<BodyMeasurement>> watchMeasurements({int limit = 30}) =>
      _dao.watchMeasurements(limit: limit);
  Future<int> insertMeasurement(BodyMeasurementsCompanion e) =>
      _dao.insertMeasurement(e);

  Stream<List<SleepLog>> watchSleepLogs({int limit = 30}) =>
      _dao.watchSleepLogs(limit: limit);
  Future<int> insertSleepLog(SleepLogsCompanion e) => _dao.insertSleepLog(e);
  Future<bool> updateSleepLog(SleepLog e) => _dao.updateSleepLog(e);
  Future<int> deleteSleepLog(int id) => _dao.deleteSleepLog(id);

  Stream<List<MoodLog>> watchMoodLogs({int limit = 30}) =>
      _dao.watchMoodLogs(limit: limit);
  Future<int> insertMoodLog(MoodLogsCompanion e) => _dao.insertMoodLog(e);

  Stream<List<PhotoLog>> watchPhotoLogs({String? category}) =>
      _dao.watchPhotoLogs(category: category);
  Future<int> insertPhotoLog(PhotoLogsCompanion e) => _dao.insertPhotoLog(e);
  Future<int> deletePhotoLog(int id) => _dao.deletePhotoLog(id);
}
