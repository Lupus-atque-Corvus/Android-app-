import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/theme/colors.dart';
import '../../data/repositories/budget_repository.dart';

class BudgetStatsScreen extends ConsumerWidget {
  const BudgetStatsScreen({super.key});

  Future<List<(String, double)>> _loadStats(BudgetRepository repo) async {
    final results = <(String, double)>[];
    final now = DateTime.now();
    for (int i = 5; i >= 0; i--) {
      final m = DateTime(now.year, now.month - i);
      final txns =
          await repo.watchTransactionsForMonth(m.year, m.month).first;
      final spent = txns
          .where((t) => t.type == 'expense')
          .fold(0.0, (s, t) => s + t.amount);
      results.add((_monthLabel(m), spent));
    }
    return results;
  }

  String _monthLabel(DateTime d) => '${d.month}/${d.year % 100}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currencySymbolProvider);
    final repo = ref.read(budgetRepositoryProvider);

    return Scaffold(
      backgroundColor: TraumColors.background,
      appBar: AppBar(
        backgroundColor: TraumColors.surface,
        elevation: 0,
        title: const Text(
          'Ausgaben-Statistik',
          style: TextStyle(
            color: TraumColors.onBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: TraumColors.onBackground),
      ),
      body: FutureBuilder<List<(String, double)>>(
        future: _loadStats(repo),
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

          final data = snapshot.data ?? [];
          final spots = data
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value.$2))
              .toList();
          final xLabels = data.map((e) => e.$1).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                TraumCard(
                  padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                  child: TraumLineChart(
                    spots: spots,
                    xLabels: xLabels,
                    height: 180,
                    color: TraumColors.coralOrange,
                  ),
                ),
                const SizedBox(height: 24),
                const SectionHeader(title: 'Monatsübersicht'),
                const SizedBox(height: 12),
                TraumCard(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(
                        TraumColors.surfaceVariant),
                    dataRowColor: WidgetStateProperty.all(
                        Colors.transparent),
                    headingTextStyle: const TextStyle(
                      color: TraumColors.onBackgroundMuted,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    dataTextStyle: const TextStyle(
                      color: TraumColors.onBackground,
                      fontSize: 13,
                    ),
                    columnSpacing: 24,
                    columns: const [
                      DataColumn(label: Text('Monat')),
                      DataColumn(
                          label: Text('Ausgaben'), numeric: true),
                    ],
                    rows: data
                        .map(
                          (entry) => DataRow(cells: [
                            DataCell(Text(entry.$1)),
                            DataCell(Text(
                              '${entry.$2.toStringAsFixed(2)} $currency',
                              style: TextStyle(
                                color: entry.$2 > 0
                                    ? TraumColors.error
                                    : TraumColors.onBackgroundMuted,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                          ]),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
