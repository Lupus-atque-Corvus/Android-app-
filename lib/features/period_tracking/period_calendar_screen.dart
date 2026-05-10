import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';
import 'cycle_calculator.dart' as cc;

class PeriodCalendarScreen extends ConsumerStatefulWidget {
  const PeriodCalendarScreen({super.key});
  @override
  ConsumerState<PeriodCalendarScreen> createState() => _PeriodCalendarScreenState();
}

class _PeriodCalendarScreenState extends ConsumerState<PeriodCalendarScreen> {
  DateTime _month = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final entriesAsync = ref.watch(StreamProvider<List<PeriodEntry>>((ref) {
      return ref.watch(periodRepositoryProvider).watchPeriodEntries(limit: 24);
    }));
    final avgCycle = ref.watch(preferencesRepositoryProvider).avgCycleLength;
    final avgPeriod = ref.watch(preferencesRepositoryProvider).avgPeriodLength;

    return Scaffold(
      appBar: AppBar(title: const Text('Zykluskalender')),
      body: entriesAsync.when(
        data: (entries) => _buildCalendar(entries, avgCycle, avgPeriod),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  Widget _buildCalendar(List<PeriodEntry> entries, int avgCycle, int avgPeriod) {
    final firstDay = DateTime(_month.year, _month.month, 1);
    final lastDay = DateTime(_month.year, _month.month + 1, 0);
    final startOffset = firstDay.weekday - 1;

    // Build set of period days and predicted/fertile days
    final periodDays = <DateTime>{};
    final fertileDays = <DateTime>{};
    final ovulationDays = <DateTime>{};
    final predictedDays = <DateTime>{};

    for (final entry in entries) {
      for (int d = 0; d < avgPeriod; d++) {
        periodDays.add(DateTime(entry.startDate.year, entry.startDate.month, entry.startDate.day + d));
      }
      final calc = cc.CycleCalculator.calculate(lastPeriodStart: entry.startDate, avgCycleLength: avgCycle, avgPeriodLength: avgPeriod);
      ovulationDays.add(DateTime(calc.ovulationDate.year, calc.ovulationDate.month, calc.ovulationDate.day));
      for (int d = 0; d <= calc.fertileEnd.difference(calc.fertileStart).inDays; d++) {
        final fd = calc.fertileStart.add(Duration(days: d));
        fertileDays.add(DateTime(fd.year, fd.month, fd.day));
      }
      final next = calc.nextPeriodPredicted;
      for (int d = 0; d < avgPeriod; d++) {
        predictedDays.add(DateTime(next.year, next.month, next.day + d));
      }
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return Column(
      children: [
        // Month navigation
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () => setState(() => _month = DateTime(_month.year, _month.month - 1)), icon: const Icon(Icons.chevron_left_rounded)),
              Text('${_monthName(_month.month)} ${_month.year}', style: Theme.of(context).textTheme.titleLarge),
              IconButton(onPressed: () => setState(() => _month = DateTime(_month.year, _month.month + 1)), icon: const Icon(Icons.chevron_right_rounded)),
            ],
          ),
        ),
        // Weekday headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'].map((d) => Expanded(
              child: Center(child: Text(d, style: const TextStyle(color: TraumColors.onBackgroundMuted, fontSize: 12))),
            )).toList(),
          ),
        ),
        const SizedBox(height: 4),
        // Day grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: 1),
          itemCount: startOffset + lastDay.day,
          itemBuilder: (_, i) {
            if (i < startOffset) return const SizedBox();
            final day = DateTime(_month.year, _month.month, i - startOffset + 1);
            final isToday = day == today;
            final isPeriod = periodDays.contains(day);
            final isFertile = fertileDays.contains(day);
            final isOvulation = ovulationDays.contains(day);
            final isPredicted = predictedDays.contains(day);

            Color? bg;
            if (isPeriod) {
              bg = TraumColors.periodRose;
            } else if (isOvulation) {
              bg = TraumColors.ovulationCyan;
            } else if (isFertile) {
              bg = TraumColors.fertileCyan.withAlpha(100);
            } else if (isPredicted) {
              bg = TraumColors.periodRose.withAlpha(60);
            }

            return Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: bg,
                border: isToday ? Border.all(color: TraumColors.coralOrange, width: 2) : null,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    fontSize: 12,
                    color: bg != null ? Colors.white : TraumColors.onBackground,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
        // Legend
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 16,
            children: [
              _LegendItem(color: TraumColors.periodRose, label: 'Periode'),
              _LegendItem(color: TraumColors.ovulationCyan, label: 'Eisprung'),
              _LegendItem(color: TraumColors.fertileCyan, label: 'Fruchtbar'),
              _LegendItem(color: TraumColors.periodRose.withAlpha(60), label: 'Prognose'),
            ],
          ),
        ),
      ],
    );
  }

  String _monthName(int month) {
    const names = ['Januar','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'];
    return names[month - 1];
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      const SizedBox(width: 4),
      Text(label, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
}
