import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/navigation/routes.dart';
import '../../data/database/traum_database.dart';

// ─────────────────────────────────────────────────────────────────────────────
// BudgetScreen
// ─────────────────────────────────────────────────────────────────────────────

class BudgetScreen extends ConsumerStatefulWidget {
  const BudgetScreen({super.key});

  @override
  ConsumerState<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends ConsumerState<BudgetScreen> {
  DateTime _focusedMonth =
      DateTime(DateTime.now().year, DateTime.now().month);

  static const _monthNames = [
    'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni',
    'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember',
  ];

  void _prevMonth() => setState(() {
        _focusedMonth =
            DateTime(_focusedMonth.year, _focusedMonth.month - 1);
      });

  void _nextMonth() => setState(() {
        _focusedMonth =
            DateTime(_focusedMonth.year, _focusedMonth.month + 1);
      });

  @override
  Widget build(BuildContext context) {
    final currency = ref.watch(currencySymbolProvider);

    final transactionsAsync = ref.watch(
      _transactionsForMonthProvider((_focusedMonth.year, _focusedMonth.month)),
    );
    final categoriesAsync = ref.watch(_categoriesProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // ── Month navigation ────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _prevMonth,
                        icon: const Icon(Icons.chevron_left),
                        color: TraumColors.onBackground,
                      ),
                      Text(
                        '${_monthNames[_focusedMonth.month - 1]} ${_focusedMonth.year}',
                        style: const TextStyle(
                          color: TraumColors.onBackground,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: _nextMonth,
                        icon: const Icon(Icons.chevron_right),
                        color: TraumColors.onBackground,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // ── Balance hero card ────────────────────────────────
                  transactionsAsync.when(
                    data: (txns) => _BalanceCard(
                      transactions: txns,
                      currency: currency,
                    ),
                    loading: () => const ShimmerLoader(height: 120),
                    error: (e, _) => Text('Fehler: $e'),
                  ),
                  const SizedBox(height: 20),
                  // ── Donut chart ──────────────────────────────────────
                  transactionsAsync.when(
                    data: (txns) => categoriesAsync.when(
                      data: (cats) => _SpendingDonut(
                        transactions: txns,
                        categories: cats,
                        currency: currency,
                      ),
                      loading: () => const ShimmerLoader(height: 160),
                      error: (e, _) => Text('Fehler: $e'),
                    ),
                    loading: () => const ShimmerLoader(height: 160),
                    error: (e, _) => Text('Fehler: $e'),
                  ),
                  const SizedBox(height: 20),
                  // ── Categories ───────────────────────────────────────
                  categoriesAsync.when(
                    data: (cats) {
                      final limCats = cats
                          .where((c) =>
                              c.monthlyLimit != null && c.monthlyLimit! > 0)
                          .toList();
                      if (limCats.isEmpty) return const SizedBox.shrink();
                      return transactionsAsync.when(
                        data: (txns) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeader(title: 'Kategorien'),
                            const SizedBox(height: 8),
                            ...limCats.map((cat) {
                              final spent = txns
                                  .where((t) =>
                                      t.categoryId == cat.id &&
                                      t.type == 'expense')
                                  .fold(0.0, (s, t) => s + t.amount);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: BudgetCategoryBar(
                                  label:
                                      '${cat.emoji ?? ''} ${cat.name}'.trim(),
                                  value: spent,
                                  limit: cat.monthlyLimit!,
                                  currencySymbol: currency,
                                ),
                              );
                            }),
                            const SizedBox(height: 8),
                          ],
                        ),
                        loading: () => const ShimmerLoader(height: 80),
                        error: (e, _) => Text('Fehler: $e'),
                      );
                    },
                    loading: () => const ShimmerLoader(height: 80),
                    error: (e, _) => Text('Fehler: $e'),
                  ),
                  // ── Recent transactions ──────────────────────────────
                  SectionHeader(title: 'Letzte Transaktionen'),
                  const SizedBox(height: 8),
                  transactionsAsync.when(
                    data: (txns) => categoriesAsync.when(
                      data: (cats) => _TransactionList(
                        transactions: txns,
                        categories: cats,
                        currency: currency,
                      ),
                      loading: () => const ShimmerLoader(height: 120),
                      error: (e, _) => Text('Fehler: $e'),
                    ),
                    loading: () => const ShimmerLoader(height: 120),
                    error: (e, _) => Text('Fehler: $e'),
                  ),
                  const SizedBox(height: 80),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab_budget',
        backgroundColor: TraumColors.coralOrange,
        onPressed: () => context.push(Routes.addTransaction),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stream providers
// ─────────────────────────────────────────────────────────────────────────────

// These are rebuilt by BudgetScreen which passes year/month to the notifier.
// We use AutoDispose providers parameterised by (year, month) tuple.
final _transactionsForMonthProvider =
    StreamProvider.family<List<Transaction>, (int, int)>(
  (ref, ym) =>
      ref.watch(budgetRepositoryProvider).watchTransactionsForMonth(ym.$1, ym.$2),
);

final _categoriesProvider = StreamProvider<List<BudgetCategory>>((ref) =>
    ref.watch(budgetRepositoryProvider).watchCategories());

// ─────────────────────────────────────────────────────────────────────────────
// Balance hero card
// ─────────────────────────────────────────────────────────────────────────────

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({
    required this.transactions,
    required this.currency,
  });

  final List<Transaction> transactions;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final income = transactions
        .where((t) => t.type == 'income')
        .fold(0.0, (s, t) => s + t.amount);
    final expense = transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (s, t) => s + t.amount);
    final saldo = income - expense;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: TraumColors.gradientWarm,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _BalanceStat(
              label: 'Einnahmen',
              amount: income,
              currency: currency,
              color: Colors.white),
          const _Divider(),
          _BalanceStat(
              label: 'Ausgaben',
              amount: expense,
              currency: currency,
              color: Colors.white70),
          const _Divider(),
          _BalanceStat(
              label: 'Saldo',
              amount: saldo,
              currency: currency,
              color: saldo >= 0 ? Colors.white : Colors.red.shade200),
        ],
      ),
    );
  }
}

class _BalanceStat extends StatelessWidget {
  const _BalanceStat({
    required this.label,
    required this.amount,
    required this.currency,
    required this.color,
  });

  final String label;
  final double amount;
  final String currency;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(label,
              style:
                  const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            '${amount.toStringAsFixed(2)} $currency',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1, height: 40, color: Colors.white38,
        margin: const EdgeInsets.symmetric(horizontal: 8));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Spending donut chart
// ─────────────────────────────────────────────────────────────────────────────

class _SpendingDonut extends StatelessWidget {
  const _SpendingDonut({
    required this.transactions,
    required this.categories,
    required this.currency,
  });

  final List<Transaction> transactions;
  final List<BudgetCategory> categories;
  final String currency;

  // Palette for categories that have no color stored
  static const _palette = [
    TraumColors.coralOrange,
    TraumColors.cyanBlue,
    TraumColors.peachOrange,
    TraumColors.turquoiseBlue,
    TraumColors.warning,
    TraumColors.success,
  ];

  @override
  Widget build(BuildContext context) {
    final expenses =
        transactions.where((t) => t.type == 'expense').toList();
    if (expenses.isEmpty) return const SizedBox.shrink();

    // Group by category
    final Map<int?, double> grouped = {};
    for (final t in expenses) {
      grouped[t.categoryId] = (grouped[t.categoryId] ?? 0) + t.amount;
    }

    final segments = grouped.entries.map((e) {
      final cat = categories.cast<BudgetCategory?>().firstWhere(
            (c) => c?.id == e.key,
            orElse: () => null,
          );
      final idx = grouped.keys.toList().indexOf(e.key);
      return ChartSegment(
        label: cat != null ? '${cat.emoji ?? ''} ${cat.name}'.trim() : 'Sonstiges',
        value: e.value,
        color: cat?.color != null
            ? Color(cat!.color!)
            : _palette[idx % _palette.length],
        formattedAmount:
            '${e.value.toStringAsFixed(0)} $currency',
      );
    }).toList();

    return TraumCard(
      padding: const EdgeInsets.all(16),
      child: DonutChart(segments: segments),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Transaction list with swipe-to-delete
// ─────────────────────────────────────────────────────────────────────────────

class _TransactionList extends ConsumerWidget {
  const _TransactionList({
    required this.transactions,
    required this.categories,
    required this.currency,
  });

  final List<Transaction> transactions;
  final List<BudgetCategory> categories;
  final String currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(budgetRepositoryProvider);
    if (transactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Text(
            'Keine Transaktionen',
            style: TextStyle(color: TraumColors.onBackgroundMuted),
          ),
        ),
      );
    }

    // Show most-recent first, up to 20
    final sorted = [...transactions]
      ..sort((a, b) => b.date.compareTo(a.date));
    final shown = sorted.take(20).toList();

    return Column(
      children: shown.map((txn) {
        final cat = categories.cast<BudgetCategory?>().firstWhere(
              (c) => c?.id == txn.categoryId,
              orElse: () => null,
            );
        return Dismissible(
          key: ValueKey(txn.id),
          direction: DismissDirection.endToStart,
          background: _swipeDeleteBackground(),
          onDismissed: (_) => repo.deleteTransaction(txn.id),
          child: _TransactionTile(
            transaction: txn,
            category: cat,
            currency: currency,
          ),
        );
      }).toList(),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.transaction,
    required this.category,
    required this.currency,
  });

  final Transaction transaction;
  final BudgetCategory? category;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == 'income';
    final amountColor =
        isIncome ? TraumColors.success : TraumColors.error;
    final amountPrefix = isIncome ? '+' : '-';

    final d = transaction.date;
    final dateStr =
        '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';

    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      title: Text(
        transaction.description,
        style: const TextStyle(
          color: TraumColors.onBackground,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        '${category != null ? '${category!.emoji ?? ''} ${category!.name}  •  ' : ''}$dateStr',
        style: const TextStyle(
          color: TraumColors.onBackgroundMuted,
          fontSize: 12,
        ),
      ),
      trailing: Text(
        '$amountPrefix${transaction.amount.toStringAsFixed(2)} $currency',
        style: TextStyle(
          color: amountColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

Widget _swipeDeleteBackground() => Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: TraumColors.error,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.delete_outline, color: Colors.white),
    );
