import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

// ── Logged set data class ─────────────────────────────────────────────────────

class _LoggedSet {
  _LoggedSet({
    required this.exerciseId,
    required this.exerciseName,
    required this.setNumber,
    this.weightKg,
    this.reps,
  });

  final int exerciseId;
  final String exerciseName;
  final int setNumber;
  final double? weightKg;
  final int? reps;
}

// ── ActiveWorkoutScreen ───────────────────────────────────────────────────────

class ActiveWorkoutScreen extends ConsumerStatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  ConsumerState<ActiveWorkoutScreen> createState() =>
      _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends ConsumerState<ActiveWorkoutScreen> {
  // ── Timer state ──────────────────────────────────────────────────────────
  late final DateTime _startedAt;
  int _elapsedSeconds = 0;
  StreamSubscription<int>? _elapsedSub;

  // ── Rest timer state ─────────────────────────────────────────────────────
  static const _restDuration = 90;
  int _restRemaining = _restDuration;
  bool _restActive = false;
  StreamSubscription<int>? _restSub;

  // ── Logged sets ──────────────────────────────────────────────────────────
  final List<_LoggedSet> _loggedSets = [];

  // ── Current exercise selection ───────────────────────────────────────────
  Exercise? _selectedExercise;
  int _currentSetNumber = 1;

  // ── Text controllers ─────────────────────────────────────────────────────
  final _weightController = TextEditingController();
  final _repsController = TextEditingController();

  // ── Exercises from DB ────────────────────────────────────────────────────
  List<Exercise> _exercises = [];

  @override
  void initState() {
    super.initState();
    _startedAt = DateTime.now();

    // Elapsed workout timer
    _elapsedSub = Stream.periodic(
      const Duration(seconds: 1),
      (tick) => tick + 1,
    ).listen((tick) {
      if (mounted) setState(() => _elapsedSeconds = tick);
    });

    // Load exercises on first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadExercises());
  }

  Future<void> _loadExercises() async {
    final repo = ref.read(trainingRepositoryProvider);
    repo.watchExercises().first.then((list) {
      if (mounted) setState(() => _exercises = list);
    });
  }

  @override
  void dispose() {
    _elapsedSub?.cancel();
    _restSub?.cancel();
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  String get _elapsedLabel {
    final h = _elapsedSeconds ~/ 3600;
    final m = (_elapsedSeconds % 3600) ~/ 60;
    final s = _elapsedSeconds % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:'
          '${m.toString().padLeft(2, '0')}:'
          '${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  void _startRestTimer() {
    _restSub?.cancel();
    setState(() {
      _restActive = true;
      _restRemaining = _restDuration;
    });
    _restSub = Stream.periodic(
      const Duration(seconds: 1),
      (tick) => tick + 1,
    ).listen((tick) {
      if (!mounted) return;
      final remaining = _restDuration - tick;
      if (remaining <= 0) {
        _restSub?.cancel();
        setState(() {
          _restActive = false;
          _restRemaining = _restDuration;
        });
      } else {
        setState(() => _restRemaining = remaining);
      }
    });
  }

  void _addSet() {
    if (_selectedExercise == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte zuerst eine Übung auswählen')),
      );
      return;
    }
    final weight = double.tryParse(_weightController.text);
    final reps = int.tryParse(_repsController.text);

    setState(() {
      _loggedSets.add(_LoggedSet(
        exerciseId: _selectedExercise!.id,
        exerciseName: _selectedExercise!.name,
        setNumber: _currentSetNumber,
        weightKg: weight,
        reps: reps,
      ));
      _currentSetNumber++;
    });

    _weightController.clear();
    _repsController.clear();
    _startRestTimer();
  }

  Future<void> _finishWorkout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: TraumColors.surface,
        title: const Text(
          'Training beenden',
          style: TextStyle(color: TraumColors.onBackground),
        ),
        content: Text(
          'Möchtest du das Training beenden und ${_loggedSets.length} '
          'Sätze speichern?',
          style: const TextStyle(color: TraumColors.onBackgroundMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(
              'Weiter trainieren',
              style: TextStyle(color: TraumColors.cyanBlue),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Beenden',
              style: TextStyle(color: TraumColors.coralOrange),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final repo = ref.read(trainingRepositoryProvider);
    final durationSeconds =
        DateTime.now().difference(_startedAt).inSeconds;

    final sessionId = await repo.insertSession(
      WorkoutSessionsCompanion(
        startedAt: Value(_startedAt),
        completedAt: Value(DateTime.now()),
        durationSeconds: Value(durationSeconds),
      ),
    );

    for (final set in _loggedSets) {
      await repo.insertSet(
        WorkoutSetsCompanion(
          sessionId: Value(sessionId),
          exerciseId: Value(set.exerciseId),
          setNumber: Value(set.setNumber),
          weightKg: Value(set.weightKg),
          reps: Value(set.reps),
        ),
      );
    }

    if (mounted) context.pop();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TraumColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              elapsedLabel: _elapsedLabel,
              onClose: _finishWorkout,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // ── Exercise selector ──────────────────────────
                        const SizedBox(height: 16),
                        _ExerciseSelectorCard(
                          exercises: _exercises,
                          selected: _selectedExercise,
                          setNumber: _currentSetNumber,
                          onSelected: (ex) => setState(() {
                            _selectedExercise = ex;
                            _currentSetNumber = 1;
                          }),
                        ),

                        const SizedBox(height: 16),

                        // ── Rest timer ring ────────────────────────────
                        if (_restActive)
                          _RestTimerCard(
                            remaining: _restRemaining,
                            total: _restDuration,
                          ),

                        if (_restActive) const SizedBox(height: 16),

                        // ── Set entry card ─────────────────────────────
                        _SetEntryCard(
                          weightController: _weightController,
                          repsController: _repsController,
                          onAdd: _addSet,
                          setNumber: _currentSetNumber,
                          exerciseName:
                              _selectedExercise?.name ?? 'Übung wählen',
                        ),

                        const SizedBox(height: 16),

                        // ── Logged sets list ───────────────────────────
                        if (_loggedSets.isNotEmpty) ...[
                          SectionHeader(title: 'Protokollierte Sätze'),
                          const SizedBox(height: 8),
                          ..._loggedSets.reversed.map(
                            (s) => _LoggedSetTile(set: s),
                          ),
                        ],

                        const SizedBox(height: 24),

                        // ── Finish button ──────────────────────────────
                        GradientButton(
                          label: 'Training beenden',
                          icon: Icons.stop_circle_outlined,
                          gradient: TraumColors.gradientWarm,
                          height: 56,
                          onPressed: _finishWorkout,
                        ),
                      ]),
                    ),
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

// ── Top bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({required this.elapsedLabel, required this.onClose});

  final String elapsedLabel;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: TraumColors.surface,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: TraumColors.gradientWarm,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer_outlined,
                    color: Colors.white, size: 16),
                const SizedBox(width: 6),
                Text(
                  elapsedLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Aktives Training',
                style: TextStyle(
                  color: TraumColors.onBackground,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded),
            color: TraumColors.onBackgroundMuted,
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

// ── Exercise selector card ────────────────────────────────────────────────────

class _ExerciseSelectorCard extends StatelessWidget {
  const _ExerciseSelectorCard({
    required this.exercises,
    required this.selected,
    required this.setNumber,
    required this.onSelected,
  });

  final List<Exercise> exercises;
  final Exercise? selected;
  final int setNumber;
  final ValueChanged<Exercise> onSelected;

  @override
  Widget build(BuildContext context) {
    return TraumCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selected?.name ?? 'Übung auswählen',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: selected != null
                                ? TraumColors.onBackground
                                : TraumColors.onBackgroundMuted,
                          ),
                    ),
                    if (selected != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Satz $setNumber',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: TraumColors.coralOrange),
                      ),
                    ],
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: exercises.isEmpty
                    ? null
                    : () => _showExercisePicker(context),
                icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                label: const Text('Wechseln'),
                style: TextButton.styleFrom(
                  foregroundColor: TraumColors.cyanBlue,
                ),
              ),
            ],
          ),
          if (selected?.muscleGroup != null) ...[
            const SizedBox(height: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: TraumColors.cyanDim,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                selected!.muscleGroup,
                style: const TextStyle(
                  color: TraumColors.cyanBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showExercisePicker(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: TraumColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ExercisePickerSheet(
        exercises: exercises,
        onSelected: (ex) {
          onSelected(ex);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _ExercisePickerSheet extends StatefulWidget {
  const _ExercisePickerSheet({
    required this.exercises,
    required this.onSelected,
  });

  final List<Exercise> exercises;
  final ValueChanged<Exercise> onSelected;

  @override
  State<_ExercisePickerSheet> createState() => _ExercisePickerSheetState();
}

class _ExercisePickerSheetState extends State<_ExercisePickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.exercises
        .where((e) =>
            e.name.toLowerCase().contains(_query.toLowerCase()) ||
            e.muscleGroup.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (_, scrollController) => Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: TraumColors.onBackgroundSubtle,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Übung suchen…',
                hintStyle: const TextStyle(color: TraumColors.onBackgroundMuted),
                prefixIcon: const Icon(Icons.search_rounded,
                    color: TraumColors.onBackgroundMuted),
                filled: true,
                fillColor: TraumColors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: TraumColors.onBackground),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final ex = filtered[i];
                return ListTile(
                  title: Text(
                    ex.name,
                    style: const TextStyle(color: TraumColors.onBackground),
                  ),
                  subtitle: Text(
                    ex.muscleGroup,
                    style:
                        const TextStyle(color: TraumColors.onBackgroundMuted),
                  ),
                  onTap: () => widget.onSelected(ex),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Set entry card ────────────────────────────────────────────────────────────

class _SetEntryCard extends StatelessWidget {
  const _SetEntryCard({
    required this.weightController,
    required this.repsController,
    required this.onAdd,
    required this.setNumber,
    required this.exerciseName,
  });

  final TextEditingController weightController;
  final TextEditingController repsController;
  final VoidCallback onAdd;
  final int setNumber;
  final String exerciseName;

  @override
  Widget build(BuildContext context) {
    return TraumCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Satz $setNumber eingeben',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _NumericField(
                  controller: weightController,
                  label: 'Gewicht (kg)',
                  hint: '0.0',
                  decimal: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _NumericField(
                  controller: repsController,
                  label: 'Wiederholungen',
                  hint: '0',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GradientButton(
            label: 'Satz hinzufügen',
            icon: Icons.add_rounded,
            gradient: TraumColors.gradientCool,
            height: 48,
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}

class _NumericField extends StatelessWidget {
  const _NumericField({
    required this.controller,
    required this.label,
    required this.hint,
    this.decimal = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool decimal;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: decimal),
      inputFormatters: decimal
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
          : [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(
        color: TraumColors.onBackground,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(color: TraumColors.onBackgroundMuted, fontSize: 12),
        hintText: hint,
        hintStyle: const TextStyle(color: TraumColors.onBackgroundSubtle),
        filled: true,
        fillColor: TraumColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }
}

// ── Rest timer card ───────────────────────────────────────────────────────────

class _RestTimerCard extends StatelessWidget {
  const _RestTimerCard({required this.remaining, required this.total});

  final int remaining;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = remaining / total;
    final m = remaining ~/ 60;
    final s = remaining % 60;
    final label = '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';

    return TraumCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircularProgressRing(
            value: progress,
            centerLabel: label,
            subLabel: 'Pause',
            size: 80,
            strokeWidth: 8,
            gradient: TraumColors.gradientCool,
            trackColor: TraumColors.cyanDim,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pausenzeit',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Erhol dich. Nächster Satz in $label.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Logged set tile ───────────────────────────────────────────────────────────

class _LoggedSetTile extends StatelessWidget {
  const _LoggedSetTile({required this.set});

  final _LoggedSet set;

  @override
  Widget build(BuildContext context) {
    final weight =
        set.weightKg != null ? '${set.weightKg} kg' : '– kg';
    final reps = set.reps != null ? '${set.reps} Wdh' : '– Wdh';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TraumCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                gradient: TraumColors.gradientWarm,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${set.setNumber}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                set.exerciseName,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              weight,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: TraumColors.coralOrange),
            ),
            const SizedBox(width: 12),
            Text(
              reps,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: TraumColors.cyanBlue),
            ),
          ],
        ),
      ),
    );
  }
}
