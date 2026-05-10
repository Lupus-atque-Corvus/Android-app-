import '../database/traum_database.dart';

class NutritionRepository {
  NutritionRepository(this._dao);
  final NutritionDao _dao;

  Stream<List<NutritionLog>> watchLogsForDay(DateTime day) =>
      _dao.watchLogsForDay(day);
  Future<int> insertNutritionLog(NutritionLogsCompanion e) =>
      _dao.insertNutritionLog(e);
  Future<int> deleteNutritionLog(int id) => _dao.deleteNutritionLog(id);

  Stream<List<MealTemplate>> watchTemplates({String? category}) =>
      _dao.watchTemplates(category: category);
  Future<List<MealTemplate>> searchTemplates(String query) =>
      _dao.searchTemplates(query);
  Future<int> insertTemplate(MealTemplatesCompanion e) =>
      _dao.insertTemplate(e);
  Future<int> deleteTemplate(int id) => _dao.deleteTemplate(id);

  Stream<List<WaterLog>> watchWaterLogsForDay(DateTime day) =>
      _dao.watchWaterLogsForDay(day);
  Future<int> insertWaterLog(WaterLogsCompanion e) => _dao.insertWaterLog(e);

  Stream<List<ShoppingListItem>> watchShoppingList() =>
      _dao.watchShoppingList();
  Future<int> insertShoppingItem(ShoppingListItemsCompanion e) =>
      _dao.insertShoppingItem(e);
  Future<bool> updateShoppingItem(ShoppingListItem e) =>
      _dao.updateShoppingItem(e);
  Future<int> deleteShoppingItem(int id) => _dao.deleteShoppingItem(id);
  Future<int> clearCheckedItems() => _dao.clearCheckedItems();
}
