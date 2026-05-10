import '../database/traum_database.dart';

class MedicationRepository {
  MedicationRepository(this._dao);
  final MedicationDao _dao;

  Stream<List<Medication>> watchMedications({bool activeOnly = true}) =>
      _dao.watchMedications(activeOnly: activeOnly);
  Future<int> insertMedication(MedicationsCompanion e) =>
      _dao.insertMedication(e);
  Future<bool> updateMedication(Medication e) => _dao.updateMedication(e);
  Future<int> deleteMedication(int id) => _dao.deleteMedication(id);

  Stream<List<MedicationLog>> watchLogsForDay(DateTime day) =>
      _dao.watchLogsForDay(day);
  Future<int> insertLog(MedicationLogsCompanion e) => _dao.insertLog(e);
  Future<bool> updateLog(MedicationLog e) => _dao.updateLog(e);
}
