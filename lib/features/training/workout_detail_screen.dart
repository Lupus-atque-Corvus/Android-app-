import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/traum_database.dart';

// ── WorkoutDetailScreen ───────────────────────────────────────────────────────

class WorkoutDetailScreen extends ConsumerWidget {
  const WorkoutDetailScreen({super.key, required this.sessionId});

  final int sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(trainingRepositoryProvider);

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
          'Einheit #$sessionId',
          style: const TextStyle(
            color: TraumColors.onBackground,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: StreamBuilder<WorkoutSession?>(
        stream: repo.watchSession(sessionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: TraumColors.coralOrange),
            );
          }

          final session = snapshot.data;
          if (session == null) {
            return _EmptyState(
              icon: Icons.fitness_center_rounded,
              message: 'Keine Einheit gefunden',
            );
          }

          return _SessionBody(session: session, repo: repo);
        },
      ),
    );
  }
}

// ── Session body ──────────────────────────────────────────────────────────────

class _SessionBody extends StatelessWidget {
  const _SessionBody({required this.session, required this.repo});

  final WorkoutSession session;
  final dynamic repo; // TrainingRepository

  String _formatDateTime(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final mo = dt.month.toString().padLeft(2, '0');
    final y = dt.year;
    final h = dt.hour.toString().padLeft(2, '0');
    final mi = dt.minute.toString().padLeft(2, '0');
    return '$d.$mo.$y $h:$mi';
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          sliver: SliverToBoxAdapter(
            child: _SessionInfoCard(
              session: session,
              formattedDate: _formatDateTime(session.startedAt),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          sliver: SliverToBoxAdapter(
            child: SectionHeader(title: 'Übungen & Sätze'),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
          sliver: SliverToBoxAdapter(
            child: FutureBuilder<List<WorkoutSet>>(
              future: repo.getSetsForSession(session.id) as Future<List<WorkoutSet>>,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const ShimmerLoader(height: 120);
                }
                final sets = snap.data ?? [];
                if (sets.isEmpty) {
                  return _EmptyState(
                    icon: Icons.list_alt_rounded,
                    message: 'Keine Sätze aufgezeichnet',
                  );
                }
                return _SetsGroupedList(sets: sets, repo: repo);
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ── Session info card ─────────────────────────────────────────────────────────

class _SessionInfoCard extends StatelessWidget {
  const _SessionInfoCard({
    required this.session,
    required this.formattedDate,
  });

  final WorkoutSession session;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    final duration = session.durationSeconds;
    return TraumCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date row
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  gradient: TraumColors.gradientWarm,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: TraumColors.onBackground,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Trainingsdatum',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: TraumColors.onBackgroundMuted,
                        ),
                  ),
                ],
              ),
            ],
          ),

          if (duration != null) ...[
            const SizedBox(height: 16),
            const Divider(color: TraumColors.surfaceVariant, height: 1),
            const SizedBox(height: 16),
            // Duration row
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    gradient: TraumColors.gradientCool,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.timer_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatDuration(duration),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: TraumColors.onBackground,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Dauer',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: TraumColors.onBackgroundMuted,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],

          if (session.notes != null && session.notes!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(color: TraumColors.surfaceVariant, height: 1),
            const SizedBox(height: 16),
            // Notes row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.notes_rounded,
                  color: TraumColors.onBackgroundMuted,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    session.notes!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: TraumColors.onBackgroundMuted,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ── Sets grouped list ─────────────────────────────────────────────────────────

class _SetsGroupedList extends StatelessWidget {
  const _SetsGroupedList({required this.sets, required this.repo});

  final List<WorkoutSet> sets;
  final dynamic repo; // TrainingRepository

  /// Group sets by exerciseId, preserving encounter order.
  Map<int, List<WorkoutSet>> _groupByExercise() {
    final map = <int, List<WorkoutSet>>{};
    for (final s in sets) {
      map.putIfAbsent(s.exerciseId, () => []).add(s);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final groups = _groupByExercise();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groups.entries.map((entry) {
        return _ExerciseGroup(
          exerciseId: entry.key,
          sets: entry.value,
          repo: repo,
        );
      }).toList(),
    );
  }
}

// ── Exercise group ────────────────────────────────────────────────────────────

class _ExerciseGroup extends StatelessWidget {
  const _ExerciseGroup({
    required this.exerciseId,
    required this.sets,
    required this.repo,
  });

  final int exerciseId;
  final List<WorkoutSet> sets;
  final dynamic repo; // TrainingRepository

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Exercise?>(
      future: repo.getExercise(exerciseId) as Future<Exercise?>,
      builder: (context, snap) {
        final name = snap.data?.name ?? 'Übung #$exerciseId';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: name),
            const SizedBox(height: 8),
            TraumCard(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: TraumColors.surfaceVariant,
                ),
                child: DataTable(
                  headingRowHeight: 36,
                  dataRowMinHeight: 40,
                  dataRowMaxHeight: 40,
                  columnSpacing: 24,
                  headingTextStyle: const TextStyle(
                    color: TraumColors.onBackgroundMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  dataTextStyle: const TextStyle(
                    color: TraumColors.onBackground,
                    fontSize: 14,
                  ),
                  columns: const [
                    DataColumn(label: Text('Satz')),
                    DataColumn(
                      label: Text('Gewicht (kg)'),
                      numeric: true,
                    ),
                    DataColumn(label: Text('Wdh.'), numeric: true),
                  ],
                  rows: sets.map((s) {
                    final weight = s.weightKg != null
                        ? s.weightKg!.toStringAsFixed(1)
                        : '–';
                    final reps = s.reps?.toString() ?? '–';
                    return DataRow(cells: [
                      DataCell(Text('${s.setNumber}')),
                      DataCell(Text(
                        weight,
                        style: const TextStyle(color: TraumColors.coralOrange),
                      )),
                      DataCell(Text(
                        reps,
                        style: const TextStyle(color: TraumColors.cyanBlue),
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
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
