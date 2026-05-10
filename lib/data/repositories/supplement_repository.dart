import '../database/traum_database.dart';

class SupplementRepository {
  SupplementRepository(this._dao);
  final SupplementDao _dao;

  Stream<List<Supplement>> watchSupplements({bool activeOnly = true}) =>
      _dao.watchSupplements(activeOnly: activeOnly);
  Future<int> insertSupplement(SupplementsCompanion e) =>
      _dao.insertSupplement(e);
  Future<bool> updateSupplement(Supplement e) => _dao.updateSupplement(e);
  Future<int> deleteSupplement(int id) => _dao.deleteSupplement(id);

  Stream<List<SupplementLog>> watchLogsForDay(DateTime day) =>
      _dao.watchLogsForDay(day);
  Future<int> insertLog(SupplementLogsCompanion e) => _dao.insertLog(e);
  Future<int> deleteLog(int id) => _dao.deleteLog(id);
}
