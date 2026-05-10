import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../data/database/traum_database.dart';

// ── Muscle-group tab data ─────────────────────────────────────────────────────

class _Tab {
  const _Tab({required this.label, this.filterKey});
  final String label;
  final String? filterKey; // null = "Alle"
}

const _tabs = [
  _Tab(label: 'Alle'),
  _Tab(label: 'Brust', filterKey: 'chest'),
  _Tab(label: 'Rücken', filterKey: 'back'),
  _Tab(label: 'Schultern', filterKey: 'shoulders'),
  _Tab(label: 'Bizeps', filterKey: 'biceps'),
  _Tab(label: 'Trizeps', filterKey: 'triceps'),
  _Tab(label: 'Beine', filterKey: 'legs'),
  _Tab(label: 'Core', filterKey: 'core'),
  _Tab(label: 'Kardio', filterKey: 'cardio'),
];

// ── Riverpod provider for the exercises stream ────────────────────────────────

final _exercisesProvider =
    StreamProvider.family<List<Exercise>, String?>((ref, muscleGroup) {
  final repo = ref.watch(trainingRepositoryProvider);
  return repo.watchExercises(muscleGroup: muscleGroup);
});

// ── ExerciseLibraryScreen ─────────────────────────────────────────────────────

class ExerciseLibraryScreen extends ConsumerStatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  ConsumerState<ExerciseLibraryScreen> createState() =>
      _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState
    extends ConsumerState<ExerciseLibraryScreen> {
  int _selectedTab = 0;
  String _searchQuery = '';

  String? get _activeFilter => _tabs[_selectedTab].filterKey;

  @override
  Widget build(BuildContext context) {
    final exercisesAsync = ref.watch(_exercisesProvider(_activeFilter));

    return Scaffold(
      backgroundColor: TraumColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: TraumColors.onBackgroundMuted,
                    onPressed: () => context.pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Übungsbibliothek',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: TraumColors.onBackground),
                  ),
                ],
              ),
            ),

            // ── Search field ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Übung suchen…',
                  hintStyle:
                      const TextStyle(color: TraumColors.onBackgroundMuted),
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: TraumColors.onBackgroundMuted),
                  filled: true,
                  fillColor: TraumColors.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                style: const TextStyle(color: TraumColors.onBackground),
                onChanged: (v) => setState(() => _searchQuery = v),
              ),
            ),

            // ── Muscle group tab pills ─────────────────────────────────────
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _tabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final tab = _tabs[index];
                  final isSelected = _selectedTab == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTab = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient:
                            isSelected ? TraumColors.gradientWarm : null,
                        color: isSelected
                            ? null
                            : TraumColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        tab.label,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : TraumColors.onBackgroundMuted,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // ── Exercise list ─────────────────────────────────────────────
            Expanded(
              child: exercisesAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(20),
                  child: ShimmerLoader(height: 400),
                ),
                error: (e, _) => Center(
                  child: Text(
                    'Fehler beim Laden: $e',
                    style: const TextStyle(
                        color: TraumColors.onBackgroundMuted),
                  ),
                ),
                data: (exercises) {
                  final filtered = _searchQuery.isEmpty
                      ? exercises
                      : exercises
                          .where((e) =>
                              e.name
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()) ||
                              e.muscleGroup
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()))
                          .toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.fitness_center_rounded,
                              color: TraumColors.onBackgroundSubtle,
                              size: 48),
                          const SizedBox(height: 12),
                          Text(
                            _searchQuery.isEmpty
                                ? 'Keine Übungen in dieser Kategorie'
                                : 'Keine Ergebnisse für "$_searchQuery"',
                            style: const TextStyle(
                                color: TraumColors.onBackgroundMuted),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final ex = filtered[index];
                      return _ExerciseTile(exercise: ex);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ── FAB: add custom exercise ─────────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddExerciseDialog(context),
        backgroundColor: TraumColors.coralOrange,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Eigene Übung',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ── Add custom exercise dialog ─────────────────────────────────────────────

  Future<void> _showAddExerciseDialog(BuildContext context) async {
    final nameController = TextEditingController();
    String? selectedMuscleGroup;
    final formKey = GlobalKey<FormState>();

    const muscleGroups = [
      'chest',
      'back',
      'shoulders',
      'biceps',
      'triceps',
      'legs',
      'core',
      'cardio',
    ];

    const muscleGroupLabels = {
      'chest': 'Brust',
      'back': 'Rücken',
      'shoulders': 'Schultern',
      'biceps': 'Bizeps',
      'triceps': 'Trizeps',
      'legs': 'Beine',
      'core': 'Core',
      'cardio': 'Kardio',
    };

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              backgroundColor: TraumColors.surface,
              title: const Text(
                'Eigene Übung hinzufügen',
                style: TextStyle(
                    color: TraumColors.onBackground,
                    fontWeight: FontWeight.bold),
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name field
                    TextFormField(
                      controller: nameController,
                      style: const TextStyle(color: TraumColors.onBackground),
                      decoration: InputDecoration(
                        labelText: 'Name der Übung',
                        labelStyle: const TextStyle(
                            color: TraumColors.onBackgroundMuted),
                        filled: true,
                        fillColor: TraumColors.surfaceVariant,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (v) =>
                          (v == null || v.trim().isEmpty)
                              ? 'Bitte einen Namen eingeben'
                              : null,
                    ),

                    const SizedBox(height: 16),

                    // Muscle group dropdown
                    const Text(
                      'Muskelgruppe',
                      style: TextStyle(
                          color: TraumColors.onBackgroundMuted, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedMuscleGroup,
                      dropdownColor: TraumColors.surfaceVariant,
                      style: const TextStyle(color: TraumColors.onBackground),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: TraumColors.surfaceVariant,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      hint: const Text(
                        'Auswählen…',
                        style: TextStyle(color: TraumColors.onBackgroundMuted),
                      ),
                      items: muscleGroups.map((key) {
                        return DropdownMenuItem(
                          value: key,
                          child: Text(muscleGroupLabels[key] ?? key),
                        );
                      }).toList(),
                      onChanged: (v) =>
                          setDialogState(() => selectedMuscleGroup = v),
                      validator: (v) => v == null
                          ? 'Bitte eine Muskelgruppe auswählen'
                          : null,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text(
                    'Abbrechen',
                    style: TextStyle(color: TraumColors.onBackgroundMuted),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    final repo = ref.read(trainingRepositoryProvider);
                    await repo.insertExercise(
                      ExercisesCompanion(
                        name: Value(nameController.text.trim()),
                        muscleGroup: Value(selectedMuscleGroup!),
                        isCustom: const Value(true),
                      ),
                    );
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: const Text(
                    'Hinzufügen',
                    style: TextStyle(color: TraumColors.coralOrange),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// ── Exercise tile ─────────────────────────────────────────────────────────────

class _ExerciseTile extends StatelessWidget {
  const _ExerciseTile({required this.exercise});

  final Exercise exercise;

  static const _groupColors = {
    'chest': TraumColors.coralOrange,
    'back': TraumColors.cyanBlue,
    'shoulders': TraumColors.peachOrange,
    'biceps': TraumColors.success,
    'triceps': TraumColors.turquoiseBlue,
    'legs': TraumColors.warning,
    'core': TraumColors.periodRose,
    'cardio': TraumColors.fertileCyan,
  };

  static const _groupLabels = {
    'chest': 'Brust',
    'back': 'Rücken',
    'shoulders': 'Schultern',
    'biceps': 'Bizeps',
    'triceps': 'Trizeps',
    'legs': 'Beine',
    'core': 'Core',
    'cardio': 'Kardio',
  };

  @override
  Widget build(BuildContext context) {
    final chipColor =
        _groupColors[exercise.muscleGroup] ?? TraumColors.onBackgroundMuted;
    final groupLabel =
        _groupLabels[exercise.muscleGroup] ?? exercise.muscleGroup;

    return TraumCard(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: chipColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.fitness_center_rounded,
            color: chipColor,
            size: 20,
          ),
        ),
        title: Text(
          exercise.name,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: const SizedBox(height: 4),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MuscleChip(label: groupLabel, color: chipColor),
            if (exercise.isCustom)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: _MuscleChip(
                  label: 'Eigene',
                  color: TraumColors.onBackgroundSubtle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MuscleChip extends StatelessWidget {
  const _MuscleChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
