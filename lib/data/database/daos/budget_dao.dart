import 'package:drift/drift.dart';
import '../traum_database.dart';

part 'budget_dao.g.dart';

@DriftAccessor(tables: [Transactions, BudgetCategories, SavingsGoals, Debts])
class BudgetDao extends DatabaseAccessor<TraumDatabase> with _$BudgetDaoMixin {
  BudgetDao(super.db);

  // Transactions
  Stream<List<Transaction>> watchTransactionsForMonth(int year, int month) {
    final start = DateTime(year, month);
    final end = DateTime(year, month + 1);
    return (select(transactions)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(start) &
              t.date.isSmallerThanValue(end))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  Stream<List<Transaction>> watchRecentTransactions({int limit = 10}) =>
      (select(transactions)
            ..orderBy([(t) => OrderingTerm.desc(t.date)])
            ..limit(limit))
          .watch();

  Future<int> insertTransaction(TransactionsCompanion entry) =>
      into(transactions).insert(entry);

  Future<bool> updateTransaction(Transaction entry) =>
      update(transactions).replace(entry);

  Future<int> deleteTransaction(int id) =>
      (delete(transactions)..where((t) => t.id.equals(id))).go();

  // BudgetCategories
  Stream<List<BudgetCategory>> watchCategories() =>
      select(budgetCategories).watch();

  Future<int> insertCategory(BudgetCategoriesCompanion entry) =>
      into(budgetCategories).insert(entry);

  Future<bool> updateCategory(BudgetCategory entry) =>
      update(budgetCategories).replace(entry);

  Future<int> deleteCategory(int id) =>
      (delete(budgetCategories)..where((t) => t.id.equals(id))).go();

  // SavingsGoals
  Stream<List<SavingsGoal>> watchSavingsGoals() =>
      (select(savingsGoals)
            ..where((t) => t.isCompleted.equals(false))
            ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
          .watch();

  Future<int> insertSavingsGoal(SavingsGoalsCompanion entry) =>
      into(savingsGoals).insert(entry);

  Future<bool> updateSavingsGoal(SavingsGoal entry) =>
      update(savingsGoals).replace(entry);

  // Debts
  Stream<List<Debt>> watchDebts() =>
      (select(debts)
            ..where((t) => t.isPaidOff.equals(false))
            ..orderBy([(t) => OrderingTerm(expression: t.dueDate)]))
          .watch();

  Future<int> insertDebt(DebtsCompanion entry) => into(debts).insert(entry);

  Future<bool> updateDebt(Debt entry) => update(debts).replace(entry);
}
