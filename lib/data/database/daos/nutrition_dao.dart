import 'package:drift/drift.dart';
import '../traum_database.dart';

part 'nutrition_dao.g.dart';

@DriftAccessor(tables: [NutritionLogs, MealTemplates, WaterLogs, ShoppingListItems])
class NutritionDao extends DatabaseAccessor<TraumDatabase>
    with _$NutritionDaoMixin {
  NutritionDao(super.db);

  // NutritionLogs
  Stream<List<NutritionLog>> watchLogsForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return (select(nutritionLogs)
          ..where((t) =>
              t.logDate.isBiggerOrEqualValue(start) &
              t.logDate.isSmallerThanValue(end))
          ..orderBy([(t) => OrderingTerm(expression: t.logDate)]))
        .watch();
  }

  Future<int> insertNutritionLog(NutritionLogsCompanion entry) =>
      into(nutritionLogs).insert(entry);

  Future<int> deleteNutritionLog(int id) =>
      (delete(nutritionLogs)..where((t) => t.id.equals(id))).go();

  // MealTemplates
  Stream<List<MealTemplate>> watchTemplates({String? category}) {
    final query = select(mealTemplates);
    if (category != null) query.where((t) => t.category.equals(category));
    query.orderBy([(t) => OrderingTerm(expression: t.name)]);
    return query.watch();
  }

  Future<List<MealTemplate>> searchTemplates(String query) =>
      (select(mealTemplates)
            ..where((t) => t.name.like('%$query%'))
            ..limit(20))
          .get();

  Future<int> insertTemplate(MealTemplatesCompanion entry) =>
      into(mealTemplates).insert(entry);

  Future<int> deleteTemplate(int id) =>
      (delete(mealTemplates)..where((t) => t.id.equals(id))).go();

  // WaterLogs
  Stream<List<WaterLog>> watchWaterLogsForDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    return (select(waterLogs)
          ..where((t) =>
              t.logDate.isBiggerOrEqualValue(start) &
              t.logDate.isSmallerThanValue(end)))
        .watch();
  }

  Future<int> insertWaterLog(WaterLogsCompanion entry) =>
      into(waterLogs).insert(entry);

  // ShoppingListItems
  Stream<List<ShoppingListItem>> watchShoppingList() =>
      (select(shoppingListItems)
            ..orderBy([
              (t) => OrderingTerm(expression: t.checked),
              (t) => OrderingTerm(expression: t.category),
              (t) => OrderingTerm(expression: t.name),
            ]))
          .watch();

  Future<int> insertShoppingItem(ShoppingListItemsCompanion entry) =>
      into(shoppingListItems).insert(entry);

  Future<bool> updateShoppingItem(ShoppingListItem entry) =>
      update(shoppingListItems).replace(entry);

  Future<int> deleteShoppingItem(int id) =>
      (delete(shoppingListItems)..where((t) => t.id.equals(id))).go();

  Future<int> clearCheckedItems() =>
      (delete(shoppingListItems)..where((t) => t.checked.equals(true))).go();
}
