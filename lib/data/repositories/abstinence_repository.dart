import '../database/traum_database.dart';
import '../database/daos/abstinence_dao.dart';

class AbstinenceRepository {
  AbstinenceRepository(this._dao);

  final AbstinenceDao _dao;

  // AbstinenceTrackers
  Stream<List<AbstinenceTracker>> watchTrackers({bool activeOnly = false}) =>
      _dao.watchTrackers(activeOnly: activeOnly);

  Future<int> insertTracker(AbstinenceTrackersCompanion entry) =>
      _dao.insertTracker(entry);

  Future<bool> updateTracker(AbstinenceTracker entry) =>
      _dao.updateTracker(entry);

  Future<int> deleteTracker(int id) => _dao.deleteTracker(id);

  // AbstinenceEvents
  Stream<List<AbstinenceEvent>> watchEventsForTracker(int trackerId) =>
      _dao.watchEventsForTracker(trackerId);

  Future<int> insertEvent(AbstinenceEventsCompanion entry) =>
      _dao.insertEvent(entry);
}
