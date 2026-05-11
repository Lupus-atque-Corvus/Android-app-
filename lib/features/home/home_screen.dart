import 'dart:async';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/navigation/routes.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/providers/weather_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/date_utils.dart' as traum_dates;
import '../../l10n/app_localizations.dart';
import '../../data/database/traum_database.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userNameProvider);
    final greet = traum_dates.greeting(name.isEmpty ? '' : ', $name');
    final motivation = traum_dates.dailyMotivation();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _TopBar(greeting: greet, motivation: motivation, onSettings: () => context.push(Routes.settings)),
                  const SizedBox(height: 4),
                  const _ClockCard(),
                  const SizedBox(height: 16),
                  _ActivityGrid(),
                  const SizedBox(height: 16),
                  _WaterCard(),
                  const SizedBox(height: 16),
                  _TodayGrid(),
                  const SizedBox(height: 16),
                  _HabitsCard(),
                  const SizedBox(height: 16),
                  _BudgetCard(),
                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── TopBar ────────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({required this.greeting, required this.motivation, required this.onSettings});
  final String greeting;
  final String motivation;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: TraumColors.onBackgroundMuted),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                motivation,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: TraumColors.onBackgroundSubtle),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onSettings,
          icon: const Icon(Icons.settings_outlined),
          color: TraumColors.onBackgroundMuted,
        ),
      ],
    );
  }
}

// ── Clock card ────────────────────────────────────────────────────────────────

class _ClockCard extends ConsumerStatefulWidget {
  const _ClockCard();

  @override
  ConsumerState<_ClockCard> createState() => _ClockCardState();
}

class _ClockCardState extends ConsumerState<_ClockCard> {
  late DateTime _now;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = _now.hour.toString().padLeft(2, '0');
    final m = _now.minute.toString().padLeft(2, '0');
    final s = _now.second.toString().padLeft(2, '0');
    final date = traum_dates.formatDate(_now);
    final weatherAsync = ref.watch(weatherProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('$h:$m', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(width: 6),
            Text(
              ':$s',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: TraumColors.onBackgroundMuted,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              date,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: TraumColors.onBackgroundMuted),
            ),
            const Spacer(),
            weatherAsync.when(
              data: (data) {
                if (data == null) return const SizedBox.shrink();
                final (icon, label, color) = _weatherInfo(data.weatherCode);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: color, size: 18),
                    const SizedBox(width: 5),
                    Text(
                      '${data.temperature.round()}°C',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: TraumColors.onBackgroundMuted,
                          ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: TraumColors.onBackgroundSubtle,
                          ),
                    ),
                  ],
                );
              },
              loading: () => const SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(strokeWidth: 1.5),
              ),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }

  static (IconData, String, Color) _weatherInfo(int code) {
    if (code == 0) return (Icons.wb_sunny_rounded, 'Sonnig', Colors.amber);
    if (code <= 2) return (Icons.wb_cloudy_rounded, 'Teils bewölkt', Colors.blueGrey);
    if (code == 3) return (Icons.cloud_rounded, 'Bewölkt', Colors.blueGrey);
    if (code <= 48) return (Icons.blur_on, 'Nebel', Colors.grey);
    if (code <= 55) return (Icons.grain, 'Nieselregen', TraumColors.cyanBlue);
    if (code <= 65) return (Icons.water_drop_rounded, 'Regen', TraumColors.cyanBlue);
    if (code <= 75) return (Icons.ac_unit_rounded, 'Schnee', Colors.lightBlue);
    if (code <= 82) return (Icons.umbrella, 'Schauer', TraumColors.cyanBlue);
    if (code >= 95) return (Icons.bolt_rounded, 'Gewitter', Colors.amber);
    return (Icons.cloud_outlined, 'Unbekannt', Colors.grey);
  }
}

// ── Activity grid ─────────────────────────────────────────────────────────────

class _ActivityGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepsGoal = ref.watch(stepsGoalProvider);

    return Column(
      children: [
        SectionHeader(title: 'Aktivität heute'),
        const SizedBox(height: 8),
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircularProgressRing(
                  value: 0.0,
                  centerLabel: '0',
                  subLabel: 'von $stepsGoal',
                  size: 90,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Schritte',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      GradientProgressBar(
                        value: 0.0,
                        gradient: TraumColors.gradientWarm,
                        height: 8,
                      ),
                      const SizedBox(height: 12),
                      Text('Kalorien',
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 8),
                      GradientProgressBar(
                        value: 0.0,
                        gradient: TraumColors.gradientCool,
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Water card ────────────────────────────────────────────────────────────────

class _WaterCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waterGoal = ref.watch(waterGoalMlProvider);
    final waterAsync = ref.watch(todayWaterMlProvider);

    final totalMl = waterAsync.valueOrNull ?? 0;
    final ratio = waterGoal > 0 ? (totalMl / waterGoal).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        SectionHeader(title: AppLocalizations.of(context).nutritionWater),
        const SizedBox(height: 8),
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$totalMl ml',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('Ziel: $waterGoal ml',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: TraumColors.onBackgroundMuted)),
                  ],
                ),
                const SizedBox(height: 12),
                GradientProgressBar(
                  value: ratio,
                  gradient: TraumColors.gradientCool,
                  height: 8,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _WaterButton(ml: 200, ref: ref),
                    const SizedBox(width: 8),
                    _WaterButton(ml: 300, ref: ref),
                    const SizedBox(width: 8),
                    _WaterButton(ml: 500, ref: ref),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WaterButton extends StatelessWidget {
  const _WaterButton({required this.ml, required this.ref});
  final int ml;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => ref.read(nutritionRepositoryProvider).insertWaterLog(
              WaterLogsCompanion(
                logDate: Value(DateTime.now()),
                amountMl: Value(ml),
              ),
            ),
        child: Text(ml == 200
            ? AppLocalizations.of(context).homeWaterAdd200
            : ml == 300
                ? AppLocalizations.of(context).homeWaterAdd300
                : AppLocalizations.of(context).homeWaterAdd500),
      ),
    );
  }
}

// ── Today grid (todos + medication) ──────────────────────────────────────────

class _TodayGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(title: AppLocalizations.of(context).planningTodos),
              const SizedBox(height: 8),
              TraumCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Keine offenen Aufgaben',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: TraumColors.onBackgroundMuted)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(title: AppLocalizations.of(context).medicationTitle),
              const SizedBox(height: 8),
              TraumCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: MedicationDotRow(
                    slots: const [],
                    onAdd: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Habits card ───────────────────────────────────────────────────────────────

class _HabitsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: AppLocalizations.of(context).planningHabits),
        const SizedBox(height: 8),
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Noch keine Gewohnheiten',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: TraumColors.onBackgroundMuted)),
          ),
        ),
      ],
    );
  }
}

// ── Budget card ───────────────────────────────────────────────────────────────

class _BudgetCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currencySymbolProvider);

    return Column(
      children: [
        SectionHeader(title: AppLocalizations.of(context).budgetTitle),
        const SizedBox(height: 8),
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Verfügbar',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text('0 $currency',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: TraumColors.success)),
                  ],
                ),
                const SizedBox(height: 12),
                GradientProgressBar(
                  value: 0.0,
                  gradient: TraumColors.gradientCool,
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
