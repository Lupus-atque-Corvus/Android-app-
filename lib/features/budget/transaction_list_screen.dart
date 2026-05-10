import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

class TransactionListScreen extends ConsumerStatefulWidget {
  const TransactionListScreen({super.key});

  @override
  ConsumerState<TransactionListScreen> createState() =>
      _TransactionListScreenState();
}

class _TransactionListScreenState
    extends ConsumerState<TransactionListScreen> {
  DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);

  static const _monthNames = [
    'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni',
    'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember',
  ];

  void _prevMonth() => setState(() {
        _month = DateTime(_month.year, _month.month - 1);
      });

  void _nextMonth() => setState(() {
        _month = DateTime(_month.year, _month.month + 1);
      });

  @override
  Widget build(BuildContext context) {
    final currency = ref.watch(currencySymbolProvider);
    final repo = ref.read(budgetRepositoryProvider);

    return Scaffold(
      backgroundColor: TraumColors.background,
      appBar: AppBar(
        backgroundColor: TraumColors.surface,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _prevMonth,
              icon: const Icon(Icons.chevron_left, color: TraumColors.onBackground),
            ),
            Text(
              '${_monthNames[_month.month - 1]} ${_month.year}',
              style: const TextStyle(
                color: TraumColors.onBackground,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: _nextMonth,
              icon: const Icon(Icons.chevron_right, color: TraumColors.onBackground),
            ),
          ],
        ),
      ),
      body: StreamBuilder<List<Transaction>>(
        stream: repo.watchTransactionsForMonth(_month.year, _month.month),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Fehler: ${snapshot.error}',
                style: const TextStyle(color: TraumColors.error),
              ),
            );
          }
          final txns = snapshot.data ?? [];
          if (txns.isEmpty) {
            return Center(
              child: TraumCard(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Keine Transaktionen in diesem Monat.',
                  style: const TextStyle(color: TraumColors.onBackgroundMuted),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final sorted = [...txns]..sort((a, b) => b.date.compareTo(a.date));

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              final txn = sorted[index];
              final isIncome = txn.type == 'income';
              final d = txn.date;
              final dateStr =
                  '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
              final amountPrefix = isIncome ? '+' : '-';
              final amountColor =
                  isIncome ? TraumColors.success : TraumColors.error;

              return Dismissible(
                key: ValueKey(txn.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: TraumColors.error,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
                onDismissed: (_) => repo.deleteTransaction(txn.id),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  leading: Icon(
                    isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                    color: amountColor,
                  ),
                  title: Text(
                    txn.description,
                    style: const TextStyle(
                      color: TraumColors.onBackground,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    dateStr,
                    style: const TextStyle(
                      color: TraumColors.onBackgroundMuted,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Text(
                    '$amountPrefix${txn.amount.toStringAsFixed(2)} $currency',
                    style: TextStyle(
                      color: amountColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
