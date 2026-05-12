import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/theme/colors.dart';
import '../../l10n/app_localizations.dart';
import '../../data/database/traum_database.dart';
import 'cycle_calculator.dart' as cc;

// File-scoped provider — never recreated on rebuild
final _calendarEntriesProvider = StreamProvider<List<PeriodEntry>>((ref) {
  return ref.watch(periodRepositoryProvider).watchPeriodEntries(limit: 24);
});

class PeriodCalendarScreen extends ConsumerStatefulWidget {
  const PeriodCalendarScreen({super.key});
  @override
  ConsumerState<PeriodCalendarScreen> createState() => _PeriodCalendarScreenState();
}

class _PeriodCalendarScreenState extends ConsumerState<PeriodCalendarScreen> {
  DateTime _focused = DateTime.now();
  DateTime _selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final entriesAsync = ref.watch(_calendarEntriesProvider);
    final avgCycle = ref.watch(preferencesRepositoryProvider).avgCycleLength;
    final avgPeriod = ref.watch(preferencesRepositoryProvider).avgPeriodLength;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).periodCalendar)),
      body: entriesAsync.when(
        data: (entries) {
          if (entries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'Noch keine Zyklusdaten. Trage deine erste Periode ein um zu beginnen.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: TraumColors.onBackgroundMuted,
                  ),
                ),
              ),
            );
          }
          return _buildCalendar(entries, avgCycle, avgPeriod);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }

  Widget _buildCalendar(List<PeriodEntry> entries, int avgCycle, int avgPeriod) {
    final periodDays = <DateTime>{};
    final fertileDays = <DateTime>{};
    final ovulationDays = <DateTime>{};
    final predictedDays = <DateTime>{};

    for (final entry in entries) {
      for (int d = 0; d < avgPeriod; d++) {
        final day = entry.startDate.add(Duration(days: d));
        periodDays.add(DateTime(day.year, day.month, day.day));
      }
      final calc = cc.CycleCalculator.calculate(
        lastPeriodStart: entry.startDate,
        avgCycleLength: avgCycle,
        avgPeriodLength: avgPeriod,
      );
      ovulationDays.add(DateTime(
        calc.ovulationDate.year, calc.ovulationDate.month, calc.ovulationDate.day,
      ));
      for (int d = 0; d <= calc.fertileEnd.difference(calc.fertileStart).inDays; d++) {
        final fd = calc.fertileStart.add(Duration(days: d));
        fertileDays.add(DateTime(fd.year, fd.month, fd.day));
      }
      final next = calc.nextPeriodPredicted;
      for (int d = 0; d < avgPeriod; d++) {
        final pd = next.add(Duration(days: d));
        predictedDays.add(DateTime(pd.year, pd.month, pd.day));
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100, 12, 31),
            focusedDay: _focused,
            selectedDayPredicate: (day) => isSameDay(day, _selected),
            onDaySelected: (selected, focused) =>
                setState(() { _selected = selected; _focused = focused; }),
            onPageChanged: (focused) => setState(() => _focused = focused),
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {CalendarFormat.month: 'Monat'},
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                border: Border.all(color: TraumColors.coralOrange, width: 2),
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle(color: TraumColors.coralOrange, fontWeight: FontWeight.bold),
              selectedDecoration: const BoxDecoration(
                color: TraumColors.coralOrange,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final d = DateTime(day.year, day.month, day.day);
                Color? bg;
                if (periodDays.contains(d)) bg = TraumColors.periodRose;
                else if (ovulationDays.contains(d)) bg = TraumColors.ovulationCyan;
                else if (fertileDays.contains(d)) bg = TraumColors.fertileCyan.withValues(alpha: 0.5);
                else if (predictedDays.contains(d)) bg = TraumColors.periodRose.withValues(alpha: 0.3);
                if (bg == null) return null;
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
                  child: Center(
                    child: Text('${day.day}',
                        style: TextStyle(color: bg != null ? Colors.white : TraumColors.onBackground, fontSize: 13)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _LegendItem(color: TraumColors.periodRose, label: 'Periode'),
                _LegendItem(color: TraumColors.ovulationCyan, label: 'Eisprung'),
                _LegendItem(color: TraumColors.fertileCyan, label: 'Fruchtbar'),
                _LegendItem(color: TraumColors.periodRose.withValues(alpha: 0.3), label: 'Prognose'),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
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
