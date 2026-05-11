import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/navigation/routes.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/date_utils.dart' as traum_dates;
import '../../l10n/app_localizations.dart';
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
        title: Text(AppLocalizations.of(context).periodTitle),
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
          cc.CycleCalculation? calc;
          if (latest != null) {
            calc = cc.CycleCalculator.calculate(
              lastPeriodStart: latest.startDate,
              avgCycleLength: avgCycle,
              avgPeriodLength: avgPeriod,
            );
          }

          // Cycle irregularity check from available entries
          final cycleLengths = <int>[];
          for (int i = 0; i < entries.length - 1; i++) {
            final len =
                entries[i].startDate.difference(entries[i + 1].startDate).inDays;
            if (len > 0 && len < 60) cycleLengths.add(len);
          }
          final variation = cycleLengths.length >= 2
              ? cycleLengths.reduce((a, b) => a > b ? a : b) -
                cycleLengths.reduce((a, b) => a < b ? a : b)
              : 0;
          final isIrregular = variation >= 7;
          final hasAbnormal =
              cycleLengths.any(cc.CycleCalculator.isAbnormalCycleLength);

          final inLutealPhase = calc != null &&
              cc.CycleCalculator.isInLutealPhase(calc.nextPeriodPredicted);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroCountdownCard(calc: calc),
                const SizedBox(height: 16),
                _InfoGrid(calc: calc),
                const SizedBox(height: 12),

                // Pregnancy probability — only show when in fertile window
                if (calc != null && calc.pregnancyProbability > 0) ...[
                  _ProbabilityCard(probability: calc.pregnancyProbability),
                  const SizedBox(height: 12),
                ],

                // Luteal phase / PMS hint
                if (inLutealPhase) ...[
                  _LutealHintCard(),
                  const SizedBox(height: 12),
                ],

                // Medical alert for abnormal cycle lengths
                if (hasAbnormal || (isIrregular && cycleLengths.length >= 3)) ...[
                  _CycleAlertCard(isIrregular: isIrregular, hasAbnormal: hasAbnormal),
                  const SizedBox(height: 12),
                ],

                const SizedBox(height: 4),
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
              // Dynamic: allow entry 5 years back from today — not a hardcoded year
              firstDate: DateTime(DateTime.now().year - 5),
              lastDate: DateTime.now(),
            );
            if (d != null) startDate = d;
          },
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Abbrechen')),
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

// ── Hero countdown card ───────────────────────────────────────────────────────

class _HeroCountdownCard extends StatelessWidget {
  const _HeroCountdownCard({this.calc});
  final cc.CycleCalculation? calc;

  @override
  Widget build(BuildContext context) {
    final days =
        calc != null ? cc.CycleCalculator.daysUntilNextPeriod(calc!.nextPeriodPredicted) : null;

    final (label, daysText) = switch (days) {
      null => ('Noch keine Daten', '—'),
      0 => ('Periode erwartet', 'Heute'),
      < 0 => ('Periode überfällig', '${days.abs()} T'),
      _ => ('Tage bis zur nächsten Periode', '$days'),
    };

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
            daysText,
            style:
                Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
          ),
          Text(
            label,
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

// ── Info grid (ovulation + fertile window) ───────────────────────────────────

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({this.calc});
  final cc.CycleCalculation? calc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _InfoTile(
          label: 'Eisprung',
          value:
              calc != null ? traum_dates.formatDate(calc!.ovulationDate) : '—',
          color: TraumColors.ovulationCyan,
        ),
        const SizedBox(width: 12),
        _InfoTile(
          label: 'Fruchtbar',
          value: calc != null
              ? '${calc!.fertileStart.day}.${calc!.fertileStart.month} – '
                '${calc!.fertileEnd.day}.${calc!.fertileEnd.month}'
              : '—',
          color: TraumColors.fertileCyan,
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile(
      {required this.label, required this.value, required this.color});
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
                  Container(
                      width: 8,
                      height: 8,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle)),
                  const SizedBox(width: 6),
                  Text(label,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: TraumColors.onBackgroundMuted)),
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

// ── Pregnancy probability card ────────────────────────────────────────────────

class _ProbabilityCard extends StatelessWidget {
  const _ProbabilityCard({required this.probability});
  final double probability;

  @override
  Widget build(BuildContext context) {
    final pct = (probability * 100).round();
    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.favorite_rounded,
                color: TraumColors.periodRose, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Empfängniswahrscheinlichkeit heute',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: TraumColors.onBackgroundMuted),
              ),
            ),
            Text(
              '$pct %',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: TraumColors.periodRose),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Luteal phase / PMS hint card ─────────────────────────────────────────────

// Shows in the 14 days before the predicted period — Bäckström et al. 2003 [6]
class _LutealHintCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline_rounded,
                color: TraumColors.warning, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lutealphase aktiv',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: TraumColors.warning),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'In den ~14 Tagen vor der Periode können PMS-Symptome '
                    'wie Stimmungsschwankungen, Kopfschmerzen und Müdigkeit auftreten.',
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

// ── Abnormal cycle alert card ─────────────────────────────────────────────────

class _CycleAlertCard extends StatelessWidget {
  const _CycleAlertCard({required this.isIrregular, required this.hasAbnormal});
  final bool isIrregular;
  final bool hasAbnormal;

  @override
  Widget build(BuildContext context) {
    final msg = hasAbnormal
        ? 'Ein oder mehrere Zyklen liegen außerhalb des normalen Bereichs (21–35 Tage). '
          'Bei anhaltender Unregelmäßigkeit ärztliche Abklärung empfohlen.'
        : 'Dein Zyklus ist unregelmäßig (Schwankung ≥ 7 Tage). '
          'Bei anhaltender Unregelmäßigkeit ärztliche Abklärung empfohlen.';

    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber_rounded,
                color: TraumColors.error, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasAbnormal ? 'Zyklus auffällig' : 'Unregelmäßiger Zyklus',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: TraumColors.error),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    msg,
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

// ── Symptom entry ─────────────────────────────────────────────────────────────

class _SymptomEntry extends StatefulWidget {
  const _SymptomEntry({required this.ref});
  final WidgetRef ref;

  @override
  State<_SymptomEntry> createState() => _SymptomEntryState();
}

class _SymptomEntryState extends State<_SymptomEntry> {
  final List<String> _symptoms = [
    'Krämpfe',
    'Kopfschmerzen',
    'Stimmungsschwankungen',
    'Blähungen',
    'Müdigkeit',
    'Rückenschmerzen'
  ];
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
              children: _symptoms
                  .map((s) => FilterChip(
                        label: Text(s),
                        selected: _selected.contains(s),
                        onSelected: (v) => setState(() {
                          if (v) {
                            _selected.add(s);
                          } else {
                            _selected.remove(s);
                          }
                        }),
                      ))
                  .toList(),
            ),
            if (_selected.isNotEmpty) ...[
              const SizedBox(height: 12),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () async {
                    for (final sym in _selected) {
                      await widget.ref.read(periodRepositoryProvider).insertSymptom(
                            PeriodSymptomsCompanion.insert(
                                logDate: DateTime.now(), symptom: sym),
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

// ── Period entry tile ─────────────────────────────────────────────────────────

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
          subtitle: entry.endDate != null
              ? Text('Bis ${traum_dates.formatDate(entry.endDate!)}')
              : const Text('Andauernd'),
          trailing: IconButton(
            onPressed: () =>
                ref.read(periodRepositoryProvider).deletePeriodEntry(entry.id),
            icon: const Icon(Icons.delete_outline,
                color: TraumColors.onBackgroundMuted),
          ),
        ),
      ),
    );
  }
}
