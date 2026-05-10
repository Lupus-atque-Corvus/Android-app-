import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/navigation/routes.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/date_utils.dart' as traum_dates;
import '../../data/database/traum_database.dart';
import 'cycle_calculator.dart' as cc;

final _periodEntriesProvider = StreamProvider<List<PeriodEntry>>((ref) {
  return ref.watch(periodRepositoryProvider).watchPeriodEntries(limit: 12);
});

class PeriodScreen extends ConsumerWidget {
  const PeriodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(_periodEntriesProvider);
    final avgCycle = ref.watch(preferencesRepositoryProvider).avgCycleLength;
    final avgPeriod = ref.watch(preferencesRepositoryProvider).avgPeriodLength;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Zyklus'),
        actions: [
          IconButton(
            onPressed: () => context.push(Routes.periodCalendar),
            icon: const Icon(Icons.calendar_month_rounded),
          ),
          IconButton(
            onPressed: () => context.push(Routes.cycleHistory),
            icon: const Icon(Icons.bar_chart_rounded),
          ),
        ],
      ),
      body: entriesAsync.when(
        data: (entries) {
          final latest = entries.isNotEmpty ? entries.first : null;
          CycleCalculation? calc;
          if (latest != null) {
            final result = cc.CycleCalculator.calculate(
              lastPeriodStart: latest.startDate,
              avgCycleLength: avgCycle,
              avgPeriodLength: avgPeriod,
            );
            calc = CycleCalculation(
              ovulationDate: result.ovulationDate,
              fertileStart: result.fertileStart,
              fertileEnd: result.fertileEnd,
              nextPeriodPredicted: result.nextPeriodPredicted,
              pregnancyProbability: result.pregnancyProbability,
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroCountdownCard(calc: calc),
                const SizedBox(height: 16),
                _InfoGrid(calc: calc),
                const SizedBox(height: 24),
                SectionHeader(title: 'Symptome heute'),
                const SizedBox(height: 8),
                _SymptomEntry(ref: ref),
                const SizedBox(height: 24),
                SectionHeader(title: 'Einträge'),
                const SizedBox(height: 8),
                ...entries.map((e) => _PeriodEntryTile(entry: e, ref: ref)),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPeriodDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Periode starten'),
        backgroundColor: TraumColors.periodRose,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showAddPeriodDialog(BuildContext context, WidgetRef ref) {
    DateTime startDate = DateTime.now();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Periode eingetragen'),
        content: ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Startdatum'),
          subtitle: Text(traum_dates.formatDate(startDate)),
          trailing: const Icon(Icons.calendar_today_rounded),
          onTap: () async {
            final d = await showDatePicker(
              context: ctx,
              initialDate: startDate,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (d != null) startDate = d;
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () async {
              await ref.read(periodRepositoryProvider).insertPeriodEntry(
                    PeriodEntriesCompanion.insert(startDate: startDate),
                  );
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Eintragen'),
          ),
        ],
      ),
    );
  }
}

class CycleCalculation {
  final DateTime ovulationDate;
  final DateTime fertileStart;
  final DateTime fertileEnd;
  final DateTime nextPeriodPredicted;
  final double pregnancyProbability;
  const CycleCalculation({
    required this.ovulationDate,
    required this.fertileStart,
    required this.fertileEnd,
    required this.nextPeriodPredicted,
    required this.pregnancyProbability,
  });
}

class _HeroCountdownCard extends StatelessWidget {
  const _HeroCountdownCard({this.calc});
  final CycleCalculation? calc;

  @override
  Widget build(BuildContext context) {
    final days = calc != null
        ? cc.CycleCalculator.daysUntilNextPeriod(calc!.nextPeriodPredicted)
        : null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [TraumColors.periodRose, TraumColors.coralOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            days != null ? '$days' : '—',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: Colors.white),
          ),
          Text(
            'Tage bis zur nächsten Periode',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({this.calc});
  final CycleCalculation? calc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _InfoTile(
          label: 'Eisprung',
          value: calc != null ? traum_dates.formatDate(calc!.ovulationDate) : '—',
          color: TraumColors.ovulationCyan,
        ),
        const SizedBox(width: 12),
        _InfoTile(
          label: 'Fruchtbar',
          value: calc != null
              ? '${calc!.fertileStart.day}.${calc!.fertileStart.month} – ${calc!.fertileEnd.day}.${calc!.fertileEnd.month}'
              : '—',
          color: TraumColors.fertileCyan,
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value, required this.color});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TraumCard(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.onBackgroundMuted)),
                ],
              ),
              const SizedBox(height: 4),
              Text(value, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class _SymptomEntry extends StatefulWidget {
  const _SymptomEntry({required this.ref});
  final WidgetRef ref;

  @override
  State<_SymptomEntry> createState() => _SymptomEntryState();
}

class _SymptomEntryState extends State<_SymptomEntry> {
  final List<String> _symptoms = ['Krämpfe', 'Kopfschmerzen', 'Stimmungsschwankungen', 'Blähungen', 'Müdigkeit', 'Rückenschmerzen'];
  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _symptoms.map((s) => FilterChip(
                label: Text(s),
                selected: _selected.contains(s),
                onSelected: (v) => setState(() {
                  if (v) _selected.add(s); else _selected.remove(s);
                }),
              )).toList(),
            ),
            if (_selected.isNotEmpty) ...[
              const SizedBox(height: 12),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () async {
                    for (final sym in _selected) {
                      await widget.ref.read(periodRepositoryProvider).insertSymptom(
                        PeriodSymptomsCompanion.insert(logDate: DateTime.now(), symptom: sym),
                      );
                    }
                    setState(() => _selected.clear());
                  },
                  child: const Text('Speichern'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PeriodEntryTile extends StatelessWidget {
  const _PeriodEntryTile({required this.entry, required this.ref});
  final PeriodEntry entry;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TraumCard(
        child: ListTile(
          leading: Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: TraumColors.periodRose,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          title: Text(traum_dates.formatDate(entry.startDate)),
          subtitle: entry.endDate != null ? Text('Bis ${traum_dates.formatDate(entry.endDate!)}') : const Text('Andauernd'),
          trailing: IconButton(
            onPressed: () => ref.read(periodRepositoryProvider).deletePeriodEntry(entry.id),
            icon: const Icon(Icons.delete_outline, color: TraumColors.onBackgroundMuted),
          ),
        ),
      ),
    );
  }
}
