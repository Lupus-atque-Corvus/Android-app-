import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/streak.dart';
import '../../core/utils/date_utils.dart' as traum_dates;
import '../../l10n/app_localizations.dart';
import '../../data/database/traum_database.dart';

// ── Providers ─────────────────────────────────────────────────────────────────
final _appointmentsProvider = StreamProvider<List<Appointment>>((ref) {
  return ref.watch(planningRepositoryProvider).watchAppointments();
});

final _todosProvider = StreamProvider<List<Todo>>((ref) {
  return ref.watch(planningRepositoryProvider).watchTodos();
});

final _goalsProvider = StreamProvider<List<Goal>>((ref) {
  return ref.watch(planningRepositoryProvider).watchGoals();
});

final _habitsProvider = StreamProvider<List<Habit>>((ref) {
  return ref.watch(planningRepositoryProvider).watchHabits();
});

final _habitLogsThisWeekProvider = StreamProvider<List<HabitLog>>((ref) {
  return ref.watch(planningRepositoryProvider).watchHabitLogsForWeek(traum_dates.startOfWeek(DateTime.now()));
});

// ── Main screen ───────────────────────────────────────────────────────────────
class PlanningScreen extends ConsumerStatefulWidget {
  const PlanningScreen({super.key});
  @override
  ConsumerState<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends ConsumerState<PlanningScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).planningTitle),
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(text: 'Kalender'),
            Tab(text: 'Todos'),
            Tab(text: 'Ziele'),
            Tab(text: 'Gewohnheiten'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: const [
          _CalendarTab(),
          _TodosTab(),
          _GoalsTab(),
          _HabitsTab(),
        ],
      ),
    );
  }
}

// ── Calendar tab ──────────────────────────────────────────────────────────────
class _CalendarTab extends ConsumerStatefulWidget {
  const _CalendarTab();
  @override
  ConsumerState<_CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends ConsumerState<_CalendarTab> {
  DateTime _selected = DateTime.now();
  DateTime _month = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final apptAsync = ref.watch(_appointmentsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month nav
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () => setState(() => _month = DateTime(_month.year, _month.month - 1)), icon: const Icon(Icons.chevron_left_rounded)),
              Text('${_monthName(_month.month)} ${_month.year}', style: Theme.of(context).textTheme.titleLarge),
              IconButton(onPressed: () => setState(() => _month = DateTime(_month.year, _month.month + 1)), icon: const Icon(Icons.chevron_right_rounded)),
            ],
          ),
          const SizedBox(height: 8),
          // Day grid
          _CalendarGrid(
            month: _month,
            selected: _selected,
            onSelect: (d) => setState(() => _selected = d),
          ),
          const SizedBox(height: 16),
          SectionHeader(title: 'Termine am ${_selected.day}.${_selected.month}.'),
          const SizedBox(height: 8),
          apptAsync.when(
            data: (appts) {
              final today = appts.where((a) => traum_dates.isSameDay(a.startTime, _selected)).toList();
              if (today.isEmpty) {
                return Text('Keine Termine', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.onBackgroundMuted));
              }
              return Column(
                children: today.map((a) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppointmentChip(
                    time: traum_dates.formatTime(a.startTime),
                    title: a.title,
                    accentColor: TraumColors.coralOrange,
                  ),
                )).toList(),
              );
            },
            loading: () => const ShimmerLoader(height: 44),
            error: (e, _) => Text(e.toString()),
          ),
        ],
      ),
    );
  }

  String _monthName(int m) {
    const n = ['Jan','Feb','Mär','Apr','Mai','Jun','Jul','Aug','Sep','Okt','Nov','Dez'];
    return n[m - 1];
  }
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid({required this.month, required this.selected, required this.onSelect});
  final DateTime month;
  final DateTime selected;
  final void Function(DateTime) onSelect;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final offset = firstDay.weekday - 1;
    final today = traum_dates.startOfDay(DateTime.now());

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: 1),
      itemCount: offset + lastDay.day,
      itemBuilder: (_, i) {
        if (i < offset) return const SizedBox();
        final day = DateTime(month.year, month.month, i - offset + 1);
        final isSelected = traum_dates.isSameDay(day, selected);
        final isToday = day == today;
        return GestureDetector(
          onTap: () => onSelect(day),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected ? TraumColors.coralOrange : (isToday ? TraumColors.coralDim : null),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('${day.day}',
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : TraumColors.onBackground,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Todos tab ─────────────────────────────────────────────────────────────────
class _TodosTab extends ConsumerStatefulWidget {
  const _TodosTab();
  @override
  ConsumerState<_TodosTab> createState() => _TodosTabState();
}

class _TodosTabState extends ConsumerState<_TodosTab> {
  bool? _filterDone;

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(_todosProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              FilterChip(label: const Text('Alle'), selected: _filterDone == null, onSelected: (_) => setState(() => _filterDone = null)),
              const SizedBox(width: 8),
              FilterChip(label: const Text('Offen'), selected: _filterDone == false, onSelected: (_) => setState(() => _filterDone = false)),
              const SizedBox(width: 8),
              FilterChip(label: const Text('Erledigt'), selected: _filterDone == true, onSelected: (_) => setState(() => _filterDone = true)),
            ],
          ),
        ),
        Expanded(
          child: todosAsync.when(
            data: (todos) {
              final filtered = _filterDone == null ? todos : todos.where((t) => t.done == _filterDone).toList();
              if (filtered.isEmpty) return Center(child: Text('Keine Todos', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.onBackgroundMuted)));
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final t = filtered[i];
                  return Dismissible(
                    key: ValueKey(t.id),
                    onDismissed: (_) => ref.read(planningRepositoryProvider).deleteTodo(t.id),
                    child: TraumCard(
                      child: CheckboxListTile(
                        title: Text(t.title, style: TextStyle(decoration: t.done ? TextDecoration.lineThrough : null)),
                        subtitle: t.note != null ? Text(t.note!) : null,
                        value: t.done,
                        onChanged: (v) => ref.read(planningRepositoryProvider).updateTodo(t.copyWith(done: v ?? false)),
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text(e.toString())),
          ),
        ),
      ],
    );
  }
}

// ── Goals tab ─────────────────────────────────────────────────────────────────
class _GoalsTab extends ConsumerWidget {
  const _GoalsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(_goalsProvider);

    return goalsAsync.when(
      data: (goals) {
        if (goals.isEmpty) return Center(child: Text('Noch keine Ziele', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.onBackgroundMuted)));
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: goals.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final g = goals[i];
            final pct = (g.targetValue != null && g.targetValue! > 0) ? g.currentValue / g.targetValue! : 0.0;
            return TraumCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(g.title, style: Theme.of(context).textTheme.titleLarge)),
                        if (g.done) const Icon(Icons.check_circle_rounded, color: TraumColors.success),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GradientProgressBar(value: pct.clamp(0.0, 1.0), gradient: TraumColors.gradientCool, height: 6),
                    const SizedBox(height: 4),
                    Text('${g.currentValue} / ${g.targetValue ?? '?'} ${g.unit ?? ''}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.onBackgroundMuted)),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}

// ── Habits tab ────────────────────────────────────────────────────────────────
class _HabitsTab extends ConsumerWidget {
  const _HabitsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(_habitsProvider);
    final logsAsync = ref.watch(_habitLogsThisWeekProvider);

    return habitsAsync.when(
      data: (habits) {
        if (habits.isEmpty) return Center(child: Text('Noch keine Gewohnheiten', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.onBackgroundMuted)));
        final logs = logsAsync.value ?? [];
        final now = DateTime.now();
        final weekStart = traum_dates.startOfWeek(now);

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: habits.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final h = habits[i];
            final habitLogs = logs.where((l) => l.habitId == h.id).toList();
            final doneDates = habitLogs.where((l) => l.done).map((l) => l.logDate).toList();
            final streak = calculateStreak(doneDates);
            final weekDone = List.generate(7, (d) {
              final day = weekStart.add(Duration(days: d));
              return habitLogs.any((l) => traum_dates.isSameDay(l.logDate, day) && l.done);
            });

            return TraumCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(h.name, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    HabitWeekRow(
                      streak: streak,
                      days: weekDone,
                      onDayTap: (dayIndex) async {
                        final day = weekStart.add(Duration(days: dayIndex));
                        final isDone = weekDone[dayIndex];
                        if (isDone) {
                          await ref.read(planningRepositoryProvider).deleteHabitLog(h.id, day);
                        } else {
                          await ref.read(planningRepositoryProvider).insertHabitLog(
                            HabitLogsCompanion.insert(habitId: h.id, logDate: day),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
    );
  }
}
