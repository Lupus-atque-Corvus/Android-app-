import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../core/navigation/routes.dart';

// ── Muscle-group category data ────────────────────────────────────────────────

class _Category {
  const _Category({required this.label, required this.key});
  final String label;
  final String key;
}

const _categories = [
  _Category(label: 'Brust', key: 'chest'),
  _Category(label: 'Rücken', key: 'back'),
  _Category(label: 'Schultern', key: 'shoulders'),
  _Category(label: 'Bizeps', key: 'biceps'),
  _Category(label: 'Trizeps', key: 'triceps'),
  _Category(label: 'Beine', key: 'legs'),
  _Category(label: 'Core', key: 'core'),
  _Category(label: 'Kardio', key: 'cardio'),
];

// ── TrainingScreen ─────────────────────────────────────────────────────────────

class TrainingScreen extends ConsumerWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(trainingRepositoryProvider);
    final plansAsync = ref.watch(
      StreamProvider((_) => repo.watchPlans()),
    );
    final sessionsAsync = ref.watch(
      StreamProvider((_) => repo.watchSessions(limit: 5)),
    );

    return Scaffold(
      backgroundColor: TraumColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── AppBar-style header ────────────────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Training',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: TraumColors.onBackground,
                                ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.history_outlined),
                      color: TraumColors.onBackgroundMuted,
                      tooltip: 'Trainingsverlauf',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // ── Body content ──────────────────────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Aktiver Plan card
                  SectionHeader(title: 'Aktiver Plan'),
                  const SizedBox(height: 8),
                  _ActivePlanCard(plansAsync: plansAsync),

                  const SizedBox(height: 20),

                  // Letztes Training card
                  SectionHeader(title: 'Letztes Training'),
                  const SizedBox(height: 8),
                  _LastSessionCard(sessionsAsync: sessionsAsync),

                  const SizedBox(height: 20),

                  // Übungsbibliothek section
                  SectionHeader(
                    title: 'Übungsbibliothek',
                    onShowAll: () => context.push(Routes.exerciseLibrary),
                  ),
                  const SizedBox(height: 10),
                  _CategoryPillRow(),

                  const SizedBox(height: 20),

                  // Trainingsfortschritt section
                  SectionHeader(title: 'Trainingsfortschritt'),
                  const SizedBox(height: 8),
                  _ProgressCard(sessionsAsync: sessionsAsync),

                  const SizedBox(height: 24),

                  // Training starten CTA
                  GradientButton(
                    label: 'Training starten',
                    icon: Icons.play_arrow_rounded,
                    gradient: TraumColors.gradientWarm,
                    height: 56,
                    onPressed: () => context.push(Routes.activeWorkout),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Active plan card ──────────────────────────────────────────────────────────

class _ActivePlanCard extends StatelessWidget {
  const _ActivePlanCard({required this.plansAsync});

  final AsyncValue<dynamic> plansAsync;

  @override
  Widget build(BuildContext context) {
    return TraumCard(
      padding: const EdgeInsets.all(16),
      child: plansAsync.when(
        loading: () => const ShimmerLoader(height: 48),
        error: (_, __) => _emptyPlan(context),
        data: (plans) {
          final active = (plans as List).where((p) => p.isActive).toList();
          if (active.isEmpty) return _emptyPlan(context);
          final plan = active.first;
          return Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  gradient: TraumColors.gradientWarm,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.name as String,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Aktiver Trainingsplan',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: TraumColors.onBackgroundMuted,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _emptyPlan(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: TraumColors.surfaceVariant,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add_rounded,
            color: TraumColors.onBackgroundMuted,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kein aktiver Plan',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: TraumColors.onBackgroundMuted),
              ),
              const SizedBox(height: 2),
              Text(
                'Erstelle deinen ersten Trainingsplan',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Last session card ─────────────────────────────────────────────────────────

class _LastSessionCard extends StatelessWidget {
  const _LastSessionCard({required this.sessionsAsync});

  final AsyncValue<dynamic> sessionsAsync;

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return 'Heute';
    if (diff.inDays == 1) return 'Gestern';
    return '${dt.day}.${dt.month}.${dt.year}';
  }

  String _formatDuration(int? seconds) {
    if (seconds == null) return '–';
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m}m ${s.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context) {
    return TraumCard(
      padding: const EdgeInsets.all(16),
      child: sessionsAsync.when(
        loading: () => const ShimmerLoader(height: 60),
        error: (_, __) => _empty(context),
        data: (sessions) {
          if ((sessions as List).isEmpty) return _empty(context);
          final s = sessions.first;
          return Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  gradient: TraumColors.gradientCool,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(s.startedAt as DateTime),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _StatChip(
                          icon: Icons.timer_outlined,
                          label: _formatDuration(s.durationSeconds as int?),
                        ),
                        const SizedBox(width: 8),
                        const _StatChip(
                          icon: Icons.bar_chart_rounded,
                          label: '– Sätze',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: TraumColors.onBackgroundMuted,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: TraumColors.surfaceVariant,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.directions_run_rounded,
            color: TraumColors.onBackgroundMuted,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Text(
          'Noch kein Training absolviert',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: TraumColors.onBackgroundMuted),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: TraumColors.surfaceVariant,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: TraumColors.onBackgroundMuted),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: TraumColors.onBackgroundMuted,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Category pill row ──────────────────────────────────────────────────────────

class _CategoryPillRow extends StatefulWidget {
  @override
  State<_CategoryPillRow> createState() => _CategoryPillRowState();
}

class _CategoryPillRowState extends State<_CategoryPillRow> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = _selected == index;
          return GestureDetector(
            onTap: () {
              setState(() => _selected = index);
              context.push(
                '${Routes.exerciseLibrary}?group=${cat.key}',
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: isSelected ? TraumColors.gradientWarm : null,
                color: isSelected ? null : TraumColors.surfaceVariant,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                cat.label,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : TraumColors.onBackgroundMuted,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Progress card ─────────────────────────────────────────────────────────────

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.sessionsAsync});

  final AsyncValue<dynamic> sessionsAsync;

  @override
  Widget build(BuildContext context) {
    return TraumCard(
      padding: const EdgeInsets.all(16),
      child: sessionsAsync.when(
        loading: () => const ShimmerLoader(height: 120),
        error: (_, __) => _chartPlaceholder(context),
        data: (sessions) {
          final list = sessions as List;
          if (list.length < 2) return _chartPlaceholder(context);

          // Build spots from last sessions (duration in minutes)
          final spots = <FlSpot>[];
          final labels = <String>[];
          for (var i = 0; i < list.length; i++) {
            final s = list[list.length - 1 - i];
            final dt = s.startedAt as DateTime;
            final dur = ((s.durationSeconds as int?) ?? 0) / 60.0;
            spots.add(FlSpot(i.toDouble(), dur));
            labels.add('${dt.day}.${dt.month}');
          }
          return TraumLineChart(
            spots: spots,
            xLabels: labels,
            color: TraumColors.coralOrange,
            gradient: TraumColors.gradientWarm,
            height: 120,
            minY: 0,
          );
        },
      ),
    );
  }

  Widget _chartPlaceholder(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.show_chart_rounded,
              color: TraumColors.onBackgroundSubtle,
              size: 36,
            ),
            const SizedBox(height: 8),
            Text(
              'Noch keine Daten vorhanden',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: TraumColors.onBackgroundSubtle),
            ),
          ],
        ),
      ),
    );
  }
}
