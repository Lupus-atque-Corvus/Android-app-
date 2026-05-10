import '../database/traum_database.dart';

class BudgetRepository {
  BudgetRepository(this._dao);
  final BudgetDao _dao;

  Stream<List<Transaction>> watchTransactionsForMonth(int year, int month) =>
      _dao.watchTransactionsForMonth(year, month);
  Stream<List<Transaction>> watchRecentTransactions({int limit = 10}) =>
      _dao.watchRecentTransactions(limit: limit);
  Future<int> insertTransaction(TransactionsCompanion e) =>
      _dao.insertTransaction(e);
  Future<bool> updateTransaction(Transaction e) => _dao.updateTransaction(e);
  Future<int> deleteTransaction(int id) => _dao.deleteTransaction(id);

  Stream<List<BudgetCategory>> watchCategories() => _dao.watchCategories();
  Future<int> insertCategory(BudgetCategoriesCompanion e) =>
      _dao.insertCategory(e);
  Future<bool> updateCategory(BudgetCategory e) => _dao.updateCategory(e);
  Future<int> deleteCategory(int id) => _dao.deleteCategory(id);

  Stream<List<SavingsGoal>> watchSavingsGoals() => _dao.watchSavingsGoals();
  Future<int> insertSavingsGoal(SavingsGoalsCompanion e) =>
      _dao.insertSavingsGoal(e);
  Future<bool> updateSavingsGoal(SavingsGoal e) => _dao.updateSavingsGoal(e);

  Stream<List<Debt>> watchDebts() => _dao.watchDebts();
  Future<int> insertDebt(DebtsCompanion e) => _dao.insertDebt(e);
  Future<bool> updateDebt(Debt e) => _dao.updateDebt(e);
}
