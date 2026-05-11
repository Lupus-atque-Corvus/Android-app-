import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/date_utils.dart' as traum_dates;
import '../../l10n/app_localizations.dart';
import '../../data/database/traum_database.dart';
import 'cycle_calculator.dart' as cc;

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
            return Center(
                child: Text('Noch keine Einträge',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: TraumColors.onBackgroundMuted)));
          }

          // Calculate cycle lengths from consecutive entries (newest first from DB)
          final rawCycleLengths = <int>[];
          for (int i = 0; i < entries.length - 1; i++) {
            final len = entries[i]
                .startDate
                .difference(entries[i + 1].startDate)
                .inDays;
            if (len > 0 && len < 60) rawCycleLengths.add(len);
          }

          // Period lengths from entries that have an end date
          final rawPeriodLengths = entries
              .where((e) => e.endDate != null)
              .map((e) => e.endDate!.difference(e.startDate).inDays)
              .where((d) => d > 0 && d <= 14)
              .toList();

          final analysis = cc.CycleCalculator.analyze(
            cycleLengths: rawCycleLengths,
            periodLengths: rawPeriodLengths,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── c) Durchschnittswerte + Status-Badge ─────────────────────
                _AvgStatsCard(analysis: analysis),
                const SizedBox(height: 16),

                // ── e) Status-Badge ───────────────────────────────────────────
                _StatusBadgeRow(analysis: analysis),
                const SizedBox(height: 20),

                // ── a) Zykluslängen-Verlauf (Linie) ──────────────────────────
                if (analysis.cycleLengths.isNotEmpty) ...[
                  SectionHeader(title: 'Zykluslängen'),
                  const SizedBox(height: 8),
                  TraumCard(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                      child: TraumLineChart(
                        color: TraumColors.periodRose,
                        spots: analysis.cycleLengths
                            .asMap()
                            .entries
                            .map((e) =>
                                FlSpot(e.key.toDouble(), e.value.toDouble()))
                            .toList(),
                        xLabels: List.generate(
                            analysis.cycleLengths.length, (i) => '${i + 1}'),
                        minY: (analysis.minCycleLength - 3).toDouble().clamp(14, 100),
                        maxY: (analysis.maxCycleLength + 3).toDouble(),
                        height: 130,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // ── b) Periodenlängen-Verlauf (Balken) ───────────────────────
                if (analysis.periodLengths.isNotEmpty) ...[
                  SectionHeader(title: 'Periodenlängen'),
                  const SizedBox(height: 8),
                  _PeriodLengthBarChart(periodLengths: analysis.periodLengths),
                  const SizedBox(height: 20),
                ],

                // ── d) Zyklustrend ────────────────────────────────────────────
                if (analysis.cycleLengths.length >= 6) ...[
                  SectionHeader(title: 'Zyklustrend'),
                  const SizedBox(height: 8),
                  _CycleTrendCard(trend: analysis.cycleTrend),
                  const SizedBox(height: 20),
                ],

                // Medical alert for abnormal / irregular cycles
                if (analysis.hasAbnormalCycle || analysis.isIrregular) ...[
                  _MedicalAlertCard(analysis: analysis),
                  const SizedBox(height: 20),
                ],

                // ── All entries list ──────────────────────────────────────────
                SectionHeader(title: 'Alle Einträge'),
                const SizedBox(height: 8),
                ...entries.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TraumCard(
                        child: ListTile(
                          leading: Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: TraumColors.periodRose,
                                  borderRadius: BorderRadius.circular(2))),
                          title: Text(traum_dates.formatDate(e.startDate)),
                          subtitle: e.endDate != null
                              ? Text(
                                  'Dauer: ${e.endDate!.difference(e.startDate).inDays} Tage')
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

// ── c) Durchschnittswerte-Card ────────────────────────────────────────────────

class _AvgStatsCard extends StatelessWidget {
  const _AvgStatsCard({required this.analysis});
  final cc.CycleAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                _StatItem(
                  label: 'Ø Zyklus',
                  value: '${analysis.avgCycleLength} T',
                  sub: analysis.hasEnoughData ? 'letzte 3 Zyklen' : 'geschätzt',
                ),
                _divider(),
                _StatItem(
                  label: 'Ø Periode',
                  value: analysis.periodLengths.isNotEmpty
                      ? '${analysis.avgPeriodLength} T'
                      : '—',
                  sub: 'Durchschnitt',
                ),
                _divider(),
                _StatItem(
                  label: 'Schwankung',
                  value: analysis.cycleLengths.length >= 2
                      ? '${analysis.variation} T'
                      : '—',
                  sub: '${analysis.minCycleLength}–${analysis.maxCycleLength} T',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 40,
        color: Colors.white.withValues(alpha: 0.08),
        margin: const EdgeInsets.symmetric(horizontal: 8),
      );
}

class _StatItem extends StatelessWidget {
  const _StatItem(
      {required this.label, required this.value, required this.sub});
  final String label;
  final String value;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: TraumColors.onBackgroundMuted)),
          const SizedBox(height: 4),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: TraumColors.periodRose)),
          Text(sub,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: TraumColors.onBackgroundSubtle, fontSize: 10)),
        ],
      ),
    );
  }
}

// ── e) Status-Badges ──────────────────────────────────────────────────────────

class _StatusBadgeRow extends StatelessWidget {
  const _StatusBadgeRow({required this.analysis});
  final cc.CycleAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (!analysis.hasEnoughData)
          _Badge(
              label: 'Zu wenig Daten',
              color: TraumColors.onBackgroundMuted,
              icon: Icons.hourglass_empty_rounded)
        else if (analysis.isIrregular)
          _Badge(
              label: 'Unregelmäßig',
              color: TraumColors.warning,
              icon: Icons.warning_amber_rounded)
        else
          _Badge(
              label: 'Regelmäßig',
              color: TraumColors.success,
              icon: Icons.check_circle_outline_rounded),
        if (analysis.hasAbnormalCycle)
          _Badge(
              label: 'Zyklus auffällig',
              color: TraumColors.error,
              icon: Icons.medical_services_outlined),
        if (analysis.hasAbnormalPeriod)
          _Badge(
              label: 'Periode auffällig',
              color: TraumColors.error,
              icon: Icons.medical_services_outlined),
        if (!analysis.hasAbnormalCycle && !analysis.hasAbnormalPeriod && analysis.hasEnoughData)
          _Badge(
              label: 'Normaler Bereich',
              color: TraumColors.success,
              icon: Icons.favorite_border_rounded),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
      {required this.label, required this.color, required this.icon});
  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ── b) Periodenlängen-Balkendiagramm ─────────────────────────────────────────

class _PeriodLengthBarChart extends StatelessWidget {
  const _PeriodLengthBarChart({required this.periodLengths});
  final List<int> periodLengths;

  @override
  Widget build(BuildContext context) {
    final maxY = (periodLengths.reduce((a, b) => a > b ? a : b) + 2).toDouble();
    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
        child: SizedBox(
          height: 130,
          child: BarChart(
            BarChartData(
              maxY: maxY,
              minY: 0,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                      BarTooltipItem(
                    '${rod.toY.round()} T',
                    TextStyle(
                        color: TraumColors.periodRose,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                  ),
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTitlesWidget: (val, meta) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '${val.toInt() + 1}',
                        style: const TextStyle(
                            color: TraumColors.onBackgroundMuted, fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
              barGroups: periodLengths.asMap().entries.map((e) {
                return BarChartGroupData(
                  x: e.key,
                  barRods: [
                    BarChartRodData(
                      toY: e.value.toDouble(),
                      color: TraumColors.periodRose,
                      width: 14,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4)),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

// ── d) Zyklustrend-Karte ──────────────────────────────────────────────────────

class _CycleTrendCard extends StatelessWidget {
  const _CycleTrendCard({required this.trend});
  final double trend;

  @override
  Widget build(BuildContext context) {
    final (icon, color, trendText) = trend > 0.5
        ? (Icons.trending_up_rounded, TraumColors.warning,
            '+${trend.abs().toStringAsFixed(1)} T länger')
        : trend < -0.5
            ? (Icons.trending_down_rounded, TraumColors.cyanBlue,
                '−${trend.abs().toStringAsFixed(1)} T kürzer')
            : (Icons.trending_flat_rounded, TraumColors.success, 'Stabil');

    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trendText,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: color),
                  ),
                  Text(
                    'Vergleich: letzte 3 Zyklen vs. Zyklen 4–6',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: TraumColors.onBackgroundMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Medical alert card ────────────────────────────────────────────────────────

class _MedicalAlertCard extends StatelessWidget {
  const _MedicalAlertCard({required this.analysis});
  final cc.CycleAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.medical_services_outlined,
                color: TraumColors.error, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ärztliche Abklärung empfohlen',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: TraumColors.error)),
                  const SizedBox(height: 2),
                  Text(
                    'Bei anhaltenden Unregelmäßigkeiten oder Zyklen außerhalb des '
                    'normalen Bereichs (21–35 Tage / Periode 2–7 Tage) sollte eine '
                    'gynäkologische Abklärung erfolgen.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: TraumColors.onBackgroundMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
