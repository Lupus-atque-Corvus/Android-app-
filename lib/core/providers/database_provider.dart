import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/traum_database.dart';

final databaseProvider = Provider<TraumDatabase>((ref) {
  final db = TraumDatabase();
  ref.onDispose(db.close);
  return db;
});

// DAOs
final planningDaoProvider = Provider((ref) => ref.watch(databaseProvider).planningDao);
final trainingDaoProvider = Provider((ref) => ref.watch(databaseProvider).trainingDao);
final healthDaoProvider = Provider((ref) => ref.watch(databaseProvider).healthDao);
final nutritionDaoProvider = Provider((ref) => ref.watch(databaseProvider).nutritionDao);
final supplementDaoProvider = Provider((ref) => ref.watch(databaseProvider).supplementDao);
final medicationDaoProvider = Provider((ref) => ref.watch(databaseProvider).medicationDao);
final abstinenceDaoProvider = Provider((ref) => ref.watch(databaseProvider).abstinenceDao);
final budgetDaoProvider = Provider((ref) => ref.watch(databaseProvider).budgetDao);
final periodDaoProvider = Provider((ref) => ref.watch(databaseProvider).periodDao);
