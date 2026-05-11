import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../l10n/app_localizations.dart';
import 'package:drift/drift.dart' show Value;
import '../../data/database/traum_database.dart';

// ─────────────────────────────────────────────────────────────────────────────
// HealthScreen
// ─────────────────────────────────────────────────────────────────────────────

class HealthScreen extends ConsumerStatefulWidget {
  const HealthScreen({super.key});

  @override
  ConsumerState<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends ConsumerState<HealthScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).healthTitle),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: TraumColors.gradientWarm,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: TraumColors.onBackgroundMuted,
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          tabs: const [
            Tab(text: 'Übersicht'),
            Tab(text: 'Schlaf'),
            Tab(text: 'Gewicht'),
            Tab(text: 'Maße'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _OverviewTab(),
          _SleepTab(),
          _WeightTab(),
          _MeasurementsTab(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 0 — Übersicht
// ─────────────────────────────────────────────────────────────────────────────

class _OverviewTab extends ConsumerWidget {
  const _OverviewTab();

  static const _sleepSpots = [
    FlSpot(0, 6.5),
    FlSpot(1, 7.0),
    FlSpot(2, 5.5),
    FlSpot(3, 8.0),
    FlSpot(4, 7.5),
    FlSpot(5, 6.0),
    FlSpot(6, 7.0),
  ];

  static const _sleepLabels = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

  static const _weightSpots = [
    FlSpot(0, 82.0),
    FlSpot(1, 81.5),
    FlSpot(2, 81.8),
    FlSpot(3, 81.2),
    FlSpot(4, 80.9),
    FlSpot(5, 80.5),
    FlSpot(6, 80.2),
  ];

  static const _weightLabels = ['KW1', 'KW2', 'KW3', 'KW4', 'KW5', 'KW6', 'KW7'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader(title: 'Schlaf letzte Woche'),
        const SizedBox(height: 8),
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
            child: TraumLineChart(
              spots: _sleepSpots,
              xLabels: _sleepLabels,
              color: TraumColors.cyanBlue,
              minY: 4,
              maxY: 10,
              height: 130,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SectionHeader(title: 'Gewichtsverlauf'),
        const SizedBox(height: 8),
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
            child: TraumLineChart(
              spots: _weightSpots,
              xLabels: _weightLabels,
              color: TraumColors.coralOrange,
              gradient: TraumColors.gradientWarm,
              minY: 78,
              maxY: 85,
              height: 130,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SectionHeader(title: 'Stimmung'),
        const SizedBox(height: 8),
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: _MoodRow(),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// Mood face button row

class _MoodRow extends ConsumerWidget {
  const _MoodRow();

  static const _moods = [
    (score: 1, emoji: '😢'),
    (score: 2, emoji: '😕'),
    (score: 3, emoji: '😐'),
    (score: 4, emoji: '🙂'),
    (score: 5, emoji: '😄'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _moods.map((m) {
        return _MoodButton(
          emoji: m.emoji,
          onTap: () => _insertMood(ref, m.score),
        );
      }).toList(),
    );
  }

  Future<void> _insertMood(WidgetRef ref, int score) async {
    final repo = ref.read(healthRepositoryProvider);
    await repo.insertMoodLog(
      MoodLogsCompanion(
        logDate: Value(DateTime.now()),
        moodScore: Value(score),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  const _MoodButton({required this.emoji, required this.onTap});
  final String emoji;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: TraumColors.surfaceVariant,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(emoji, style: const TextStyle(fontSize: 28)),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 1 — Schlaf
// ─────────────────────────────────────────────────────────────────────────────

class _SleepTab extends ConsumerStatefulWidget {
  const _SleepTab();

  @override
  ConsumerState<_SleepTab> createState() => _SleepTabState();
}

class _SleepTabState extends ConsumerState<_SleepTab> {
  TimeOfDay _bedtime = const TimeOfDay(hour: 22, minute: 30);
  TimeOfDay _wakeTime = const TimeOfDay(hour: 6, minute: 30);
  int _qualityStars = 3;

  Future<void> _pickTime(bool isBedtime) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isBedtime ? _bedtime : _wakeTime,
    );
    if (picked != null) {
      setState(() {
        if (isBedtime) {
          _bedtime = picked;
        } else {
          _wakeTime = picked;
        }
      });
    }
  }

  Future<void> _saveSleepLog() async {
    final now = DateTime.now();
    final bed = DateTime(now.year, now.month, now.day, _bedtime.hour, _bedtime.minute);
    // If bedtime is after wake time, assume bedtime was previous night
    var wake = DateTime(now.year, now.month, now.day, _wakeTime.hour, _wakeTime.minute);
    if (bed.isAfter(wake)) {
      wake = wake.add(const Duration(days: 1));
    }
    final repo = ref.read(healthRepositoryProvider);
    await repo.insertSleepLog(
      SleepLogsCompanion(
        bedtime: Value(bed),
        wakeTime: Value(wake),
        qualityStars: Value(_qualityStars),
      ),
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Schlaf gespeichert')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(
      _sleepLogsProvider,
    );

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Input card
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eintrag hinzufügen',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: TraumColors.onBackground),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _TimePickerButton(
                        label: 'Schlafenszeit',
                        time: _bedtime,
                        icon: Icons.bedtime_outlined,
                        onTap: () => _pickTime(true),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _TimePickerButton(
                        label: 'Aufwachzeit',
                        time: _wakeTime,
                        icon: Icons.wb_sunny_outlined,
                        onTap: () => _pickTime(false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Qualität:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: TraumColors.onBackgroundMuted),
                    ),
                    const SizedBox(width: 8),
                    ...List.generate(5, (i) {
                      final star = i + 1;
                      return GestureDetector(
                        onTap: () => setState(() => _qualityStars = star),
                        child: Icon(
                          star <= _qualityStars
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: star <= _qualityStars
                              ? TraumColors.peachOrange
                              : TraumColors.onBackgroundSubtle,
                          size: 28,
                        ),
                      );
                    }),
                    const Spacer(),
                    GradientButton(
                      label: 'Speichern',
                      width: 100,
                      height: 40,
                      onPressed: _saveSleepLog,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SectionHeader(title: 'Letzte Einträge'),
        const SizedBox(height: 8),
        logsAsync.when(
          data: (logs) {
            if (logs.isEmpty) {
              return _EmptyState(message: 'Noch keine Schlafdaten');
            }
            return Column(
              children: logs.map((log) => _SleepLogTile(log: log)).toList(),
            );
          },
          loading: () => const ShimmerLoader(),
          error: (e, _) => Text('Fehler: $e'),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// Sleep-logs stream provider
final _sleepLogsProvider = StreamProvider.autoDispose<List<SleepLog>>((ref) {
  return ref.watch(healthRepositoryProvider).watchSleepLogs();
});

class _TimePickerButton extends StatelessWidget {
  const _TimePickerButton({
    required this.label,
    required this.time,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final TimeOfDay time;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final formatted =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: TraumColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: TraumColors.cyanBlue),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: TraumColors.onBackgroundMuted,
                    fontSize: 10,
                  ),
                ),
                Text(
                  formatted,
                  style: const TextStyle(
                    color: TraumColors.onBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SleepLogTile extends ConsumerWidget {
  const _SleepLogTile({required this.log});
  final SleepLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bed = log.bedtime;
    final wake = log.wakeTime;
    final bedStr =
        '${bed.hour.toString().padLeft(2, '0')}:${bed.minute.toString().padLeft(2, '0')}';
    final wakeStr =
        '${wake.hour.toString().padLeft(2, '0')}:${wake.minute.toString().padLeft(2, '0')}';
    final duration = wake.difference(bed);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final stars = log.qualityStars ?? 0;

    return Dismissible(
      key: ValueKey(log.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: TraumColors.error.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: TraumColors.error),
      ),
      onDismissed: (_) async {
        await ref.read(healthRepositoryProvider).deleteSleepLog(log.id);
      },
      child: TraumCard(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: const Icon(Icons.bedtime_outlined, color: TraumColors.cyanBlue),
          title: Text(
            '$bedStr – $wakeStr',
            style: const TextStyle(
              color: TraumColors.onBackground,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            '${hours}h ${minutes}min',
            style: const TextStyle(color: TraumColors.onBackgroundMuted, fontSize: 12),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (i) {
              return Icon(
                i < stars ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 16,
                color: i < stars
                    ? TraumColors.peachOrange
                    : TraumColors.onBackgroundSubtle,
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 2 — Gewicht
// ─────────────────────────────────────────────────────────────────────────────

class _WeightTab extends ConsumerStatefulWidget {
  const _WeightTab();

  @override
  ConsumerState<_WeightTab> createState() => _WeightTabState();
}

class _WeightTabState extends ConsumerState<_WeightTab> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final kg = double.tryParse(_controller.text.replaceAll(',', '.'));
    if (kg == null) return;
    final repo = ref.read(healthRepositoryProvider);
    await repo.insertWeightLog(
      WeightLogsCompanion(
        weightKg: Value(kg),
        logDate: Value(DateTime.now()),
      ),
    );
    _controller.clear();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gewicht eingetragen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(_weightLogsProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Input card
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gewicht eintragen',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: TraumColors.onBackground),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: 'Gewicht in kg',
                          hintStyle: const TextStyle(color: TraumColors.onBackgroundSubtle),
                          suffixText: 'kg',
                          suffixStyle: const TextStyle(color: TraumColors.onBackgroundMuted),
                          filled: true,
                          fillColor: TraumColors.surfaceVariant,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                        style: const TextStyle(color: TraumColors.onBackground),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GradientButton(
                      label: 'Eintragen',
                      width: 110,
                      height: 48,
                      onPressed: _save,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Chart with data or placeholder
        logsAsync.when(
          data: (logs) {
            if (logs.isNotEmpty) {
              final spots = logs.reversed
                  .toList()
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value.weightKg))
                  .toList();
              final labels = logs.reversed
                  .map((l) => '${l.logDate.day}.${l.logDate.month}')
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Verlauf'),
                  const SizedBox(height: 8),
                  TraumCard(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                      child: TraumLineChart(
                        spots: spots,
                        xLabels: labels,
                        color: TraumColors.coralOrange,
                        gradient: TraumColors.gradientWarm,
                        height: 140,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }
            return const SizedBox.shrink();
          },
          loading: () => const ShimmerLoader(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        const SectionHeader(title: 'Letzte Einträge'),
        const SizedBox(height: 8),
        logsAsync.when(
          data: (logs) {
            if (logs.isEmpty) {
              return _EmptyState(message: 'Noch keine Gewichtsdaten');
            }
            return Column(
              children: logs.map((log) => _WeightLogTile(log: log)).toList(),
            );
          },
          loading: () => const ShimmerLoader(),
          error: (e, _) => Text('Fehler: $e'),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

final _weightLogsProvider = StreamProvider.autoDispose<List<WeightLog>>((ref) {
  return ref.watch(healthRepositoryProvider).watchWeightLogs(limit: 30);
});

class _WeightLogTile extends ConsumerWidget {
  const _WeightLogTile({required this.log});
  final WeightLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date =
        '${log.logDate.day.toString().padLeft(2, '0')}.${log.logDate.month.toString().padLeft(2, '0')}.${log.logDate.year}';

    return Dismissible(
      key: ValueKey(log.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: TraumColors.error.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline, color: TraumColors.error),
      ),
      onDismissed: (_) async {
        await ref.read(healthRepositoryProvider).deleteWeightLog(log.id);
      },
      child: TraumCard(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: const Icon(Icons.monitor_weight_outlined, color: TraumColors.coralOrange),
          title: Text(
            '${log.weightKg.toStringAsFixed(1)} kg',
            style: const TextStyle(
              color: TraumColors.onBackground,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            date,
            style: const TextStyle(color: TraumColors.onBackgroundMuted, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab 3 — Maße
// ─────────────────────────────────────────────────────────────────────────────

class _MeasurementsTab extends ConsumerStatefulWidget {
  const _MeasurementsTab();

  @override
  ConsumerState<_MeasurementsTab> createState() => _MeasurementsTabState();
}

class _MeasurementsTabState extends ConsumerState<_MeasurementsTab> {
  final _chestCtrl = TextEditingController();
  final _waistCtrl = TextEditingController();
  final _hipsCtrl = TextEditingController();
  final _thighCtrl = TextEditingController();
  final _bicepCtrl = TextEditingController();

  @override
  void dispose() {
    _chestCtrl.dispose();
    _waistCtrl.dispose();
    _hipsCtrl.dispose();
    _thighCtrl.dispose();
    _bicepCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    double? parse(TextEditingController c) =>
        double.tryParse(c.text.replaceAll(',', '.'));

    final repo = ref.read(healthRepositoryProvider);
    await repo.insertMeasurement(
      BodyMeasurementsCompanion(
        logDate: Value(DateTime.now()),
        chestCm: Value(parse(_chestCtrl)),
        waistCm: Value(parse(_waistCtrl)),
        hipsCm: Value(parse(_hipsCtrl)),
        thighCm: Value(parse(_thighCtrl)),
        bicepCm: Value(parse(_bicepCtrl)),
      ),
    );
    _chestCtrl.clear();
    _waistCtrl.clear();
    _hipsCtrl.clear();
    _thighCtrl.clear();
    _bicepCtrl.clear();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maße gespeichert')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final measurementsAsync = ref.watch(_measurementsProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Last measurement info
        measurementsAsync.when(
          data: (measurements) {
            if (measurements.isNotEmpty) {
              final last = measurements.first;
              final d = last.logDate;
              final dateStr =
                  '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Letzte Messung: $dateStr',
                  style: const TextStyle(
                    color: TraumColors.onBackgroundMuted,
                    fontSize: 13,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),

        // Input grid
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maße eingeben',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: TraumColors.onBackground),
                ),
                const SizedBox(height: 14),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.8,
                  children: [
                    _MeasurementField(
                      controller: _chestCtrl,
                      label: 'Brust',
                      icon: Icons.straighten,
                    ),
                    _MeasurementField(
                      controller: _waistCtrl,
                      label: 'Taille',
                      icon: Icons.straighten,
                    ),
                    _MeasurementField(
                      controller: _hipsCtrl,
                      label: 'Hüfte',
                      icon: Icons.straighten,
                    ),
                    _MeasurementField(
                      controller: _thighCtrl,
                      label: 'Oberschenkel',
                      icon: Icons.straighten,
                    ),
                    _MeasurementField(
                      controller: _bicepCtrl,
                      label: 'Bizeps',
                      icon: Icons.straighten,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GradientButton(
                  label: 'Speichern',
                  onPressed: _save,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

final _measurementsProvider =
    StreamProvider.autoDispose<List<BodyMeasurement>>((ref) {
  return ref.watch(healthRepositoryProvider).watchMeasurements();
});

class _MeasurementField extends StatelessWidget {
  const _MeasurementField({
    required this.controller,
    required this.label,
    required this.icon,
  });
  final TextEditingController controller;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: TraumColors.onBackgroundMuted,
          fontSize: 12,
        ),
        suffixText: 'cm',
        suffixStyle: const TextStyle(
          color: TraumColors.onBackgroundMuted,
          fontSize: 12,
        ),
        filled: true,
        fillColor: TraumColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        isDense: true,
      ),
      style: const TextStyle(color: TraumColors.onBackground, fontSize: 14),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared helpers
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: TraumColors.onBackgroundMuted,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
