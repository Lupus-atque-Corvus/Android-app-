import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

// ── ExerciseProgressScreen ────────────────────────────────────────────────────

class ExerciseProgressScreen extends ConsumerWidget {
  const ExerciseProgressScreen({super.key, required this.exerciseId});

  final int exerciseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(trainingRepositoryProvider);

    return FutureBuilder<Exercise?>(
      future: repo.getExercise(exerciseId),
      builder: (context, exerciseSnap) {
        final exerciseName =
            exerciseSnap.data?.name ?? 'Fortschritt';

        return Scaffold(
          backgroundColor: TraumColors.background,
          appBar: AppBar(
            backgroundColor: TraumColors.surface,
            foregroundColor: TraumColors.onBackground,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => context.pop(),
            ),
            title: Text(
              exerciseName,
              style: const TextStyle(
                color: TraumColors.onBackground,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          body: StreamBuilder<List<WorkoutSession>>(
            stream: repo.watchSessionsForExercise(exerciseId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: TraumColors.coralOrange),
                );
              }

              final sessions = snapshot.data ?? [];
              if (sessions.isEmpty) {
                return _EmptyState(
                  icon: Icons.show_chart_rounded,
                  message: 'Noch keine Trainingsdaten',
                );
              }

              return _ProgressBody(
                sessions: sessions,
                exerciseId: exerciseId,
                repo: repo,
              );
            },
          ),
        );
      },
    );
  }
}

// ── Progress body ─────────────────────────────────────────────────────────────

class _ProgressBody extends StatelessWidget {
  const _ProgressBody({
    required this.sessions,
    required this.exerciseId,
    required this.repo,
  });

  final List<WorkoutSession> sessions;
  final int exerciseId;
  final dynamic repo; // TrainingRepository

  String _formatDate(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final mo = dt.month.toString().padLeft(2, '0');
    final y = dt.year;
    return '$d.$mo.$y';
  }

  /// For each session, load its sets and compute max weight for this exercise.
  Future<List<_SessionMaxWeight>> _loadMaxWeights() async {
    final results = <_SessionMaxWeight>[];
    for (final session in sessions) {
      final sets = await repo.getSetsForSession(session.id) as List<WorkoutSet>;
      final exerciseSets =
          sets.where((s) => s.exerciseId == exerciseId).toList();
      double maxWeight = 0;
      for (final s in exerciseSets) {
        if ((s.weightKg ?? 0) > maxWeight) {
          maxWeight = s.weightKg ?? 0;
        }
      }
      results.add(_SessionMaxWeight(session: session, maxWeightKg: maxWeight));
    }
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<_SessionMaxWeight>>(
      future: _loadMaxWeights(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: TraumColors.coralOrange),
          );
        }

        final data = snap.data ?? [];
        if (data.isEmpty) {
          return _EmptyState(
            icon: Icons.show_chart_rounded,
            message: 'Noch keine Trainingsdaten',
          );
        }

        // Build chart data
        final spots = <FlSpot>[];
        final xLabels = <String>[];
        for (var i = 0; i < data.length; i++) {
          spots.add(FlSpot(i.toDouble(), data[i].maxWeightKg));
          xLabels.add(_formatDate(data[i].session.startedAt));
        }

        return CustomScrollView(
          slivers: [
            // Chart section
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(title: 'Maximales Gewicht'),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              sliver: SliverToBoxAdapter(
                child: TraumCard(
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                  child: spots.length < 2
                      ? _SingleDataPointPlaceholder(data: data.first)
                      : TraumLineChart(
                          spots: spots,
                          xLabels: xLabels,
                          color: TraumColors.coralOrange,
                          gradient: TraumColors.gradientWarm,
                          height: 160,
                          minY: 0,
                        ),
                ),
              ),
            ),

            // Sessions list section
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              sliver: SliverToBoxAdapter(
                child: SectionHeader(title: 'Verlauf'),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // Show most recent first
                    final item = data[data.length - 1 - index];
                    return _SessionProgressTile(item: item);
                  },
                  childCount: data.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── Session max weight tile ───────────────────────────────────────────────────

class _SessionProgressTile extends StatelessWidget {
  const _SessionProgressTile({required this.item});

  final _SessionMaxWeight item;

  String _formatDate(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final mo = dt.month.toString().padLeft(2, '0');
    final y = dt.year;
    return '$d.$mo.$y';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TraumCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                gradient: TraumColors.gradientWarm,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.fitness_center_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDate(item.session.startedAt),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: TraumColors.onBackground,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Einheit #${item.session.id}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: TraumColors.onBackgroundMuted,
                        ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${item.maxWeightKg.toStringAsFixed(1)} kg',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: TraumColors.coralOrange,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Max. Gewicht',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: TraumColors.onBackgroundMuted,
                        fontSize: 11,
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

// ── Single data point placeholder (can't draw a line with 1 point) ─────────────

class _SingleDataPointPlaceholder extends StatelessWidget {
  const _SingleDataPointPlaceholder({required this.data});

  final _SessionMaxWeight data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${data.maxWeightKg.toStringAsFixed(1)} kg',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: TraumColors.coralOrange,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Erstes Training – mehr Daten für den Chart benötigt',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: TraumColors.onBackgroundMuted,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: TraumColors.onBackgroundSubtle, size: 48),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: TraumColors.onBackgroundMuted,
                ),
          ),
        ],
      ),
    );
  }
}

// ── Data class ────────────────────────────────────────────────────────────────

class _SessionMaxWeight {
  const _SessionMaxWeight({
    required this.session,
    required this.maxWeightKg,
  });

  final WorkoutSession session;
  final double maxWeightKg;
}
