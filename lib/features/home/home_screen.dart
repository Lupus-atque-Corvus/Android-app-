import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/navigation/routes.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/date_utils.dart' as traum_dates;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userNameProvider);
    final now = DateTime.now();
    final greet = traum_dates.greeting(name.isEmpty ? '' : ', $name');

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _TopBar(greeting: greet, onSettings: () => context.push(Routes.settings)),
                  const SizedBox(height: 4),
                  _ClockCard(now: now),
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
  const _TopBar({required this.greeting, required this.onSettings});
  final String greeting;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            greeting,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: TraumColors.onBackgroundMuted),
            overflow: TextOverflow.ellipsis,
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

class _ClockCard extends StatelessWidget {
  const _ClockCard({required this.now});
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    final date = traum_dates.formatDate(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$h:$m',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          date,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: TraumColors.onBackgroundMuted),
        ),
      ],
    );
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

    return Column(
      children: [
        SectionHeader(title: 'Wasser'),
        const SizedBox(height: 8),
        TraumCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0 ml', style: Theme.of(context).textTheme.titleLarge),
                    Text('Ziel: $waterGoal ml',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: TraumColors.onBackgroundMuted)),
                  ],
                ),
                const SizedBox(height: 12),
                GradientProgressBar(
                  value: 0.0,
                  gradient: TraumColors.gradientCool,
                  height: 8,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _WaterButton(ml: 200),
                    const SizedBox(width: 8),
                    _WaterButton(ml: 300),
                    const SizedBox(width: 8),
                    _WaterButton(ml: 500),
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
  const _WaterButton({required this.ml});
  final int ml;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {},
        child: Text('+${ml}ml'),
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
              SectionHeader(title: 'Todos'),
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
              SectionHeader(title: 'Medikamente'),
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
        SectionHeader(title: 'Gewohnheiten'),
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
        SectionHeader(title: 'Budget'),
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
