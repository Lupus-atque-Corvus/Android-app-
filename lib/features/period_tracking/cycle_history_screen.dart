import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/date_utils.dart' as traum_dates;
import '../../l10n/app_localizations.dart';
import '../../data/database/traum_database.dart';

class CycleHistoryScreen extends ConsumerWidget {
  const CycleHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(StreamProvider<List<PeriodEntry>>((ref) {
      return ref.watch(periodRepositoryProvider).watchPeriodEntries(limit: 24);
    }));

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).periodMyCycles)),
      body: entriesAsync.when(
        data: (entries) {
          if (entries.isEmpty) {
            return Center(child: Text('Noch keine Einträge', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TraumColors.onBackgroundMuted)));
          }

          // Calculate cycle lengths
          final cycleLengths = <int>[];
          for (int i = 0; i < entries.length - 1; i++) {
            final len = entries[i].startDate.difference(entries[i + 1].startDate).inDays;
            if (len > 0 && len < 60) cycleLengths.add(len);
          }
          final avgCycle = cycleLengths.isNotEmpty
              ? cycleLengths.reduce((a, b) => a + b) ~/ cycleLengths.length
              : 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats row
                Row(
                  children: [
                    _StatCard(label: 'Ø Zyklus', value: '$avgCycle Tage'),
                    const SizedBox(width: 12),
                    _StatCard(label: 'Einträge', value: '${entries.length}'),
                  ],
                ),
                const SizedBox(height: 24),
                SectionHeader(title: 'Zyklusdiagramm'),
                const SizedBox(height: 8),
                if (cycleLengths.isNotEmpty)
                  TraumLineChart(
                    spots: cycleLengths.reversed.toList().asMap().entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                        .toList(),
                    xLabels: List.generate(cycleLengths.length, (i) => '${i + 1}'),
                  ),
                const SizedBox(height: 24),
                SectionHeader(title: 'Alle Einträge'),
                const SizedBox(height: 8),
                ...entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TraumCard(
                    child: ListTile(
                      leading: Container(width: 4, height: 40, decoration: BoxDecoration(color: TraumColors.periodRose, borderRadius: BorderRadius.circular(2))),
                      title: Text(traum_dates.formatDate(e.startDate)),
                      subtitle: e.endDate != null
                          ? Text('Dauer: ${e.endDate!.difference(e.startDate).inDays} Tage')
                          : null,
                    ),
                  ),
                )),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TraumCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.onBackgroundMuted)),
              const SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TraumColors.periodRose)),
            ],
          ),
        ),
      ),
    );
  }
}
