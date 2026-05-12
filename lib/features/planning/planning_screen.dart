import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
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
  return ref.watch(planningRepositoryProvider).watchHabitLogsForWeek(
    traum_dates.startOfWeek(DateTime.now()),
  );
});

// ── Main screen ───────────────────────────────────────────────────────────────
class PlanningScreen extends ConsumerStatefulWidget {
  const PlanningScreen({super.key});

  @override
  ConsumerState<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends ConsumerState<PlanningScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
    _tab.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  void _showAddAppointment(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: const Color(0xFF0F1115),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _AddAppointmentSheet(),
    );
  }

  void _showAddTodo(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: const Color(0xFF0F1115),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _AddTodoSheet(),
    );
  }

  void _showAddGoal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: const Color(0xFF0F1115),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _AddGoalSheet(),
    );
  }

  void _showAddHabit(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: const Color(0xFF0F1115),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _AddHabitSheet(),
    );
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
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: TraumColors.coralOrange,
        onPressed: () {
          switch (_tab.index) {
            case 0:
              _showAddAppointment(context);
            case 1:
              _showAddTodo(context);
            case 2:
              _showAddGoal(context);
            case 3:
              _showAddHabit(context);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
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
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  static Map<DateTime, List<Appointment>> _buildEventMap(
      List<Appointment> appts) {
    final map = <DateTime, List<Appointment>>{};
    for (final a in appts) {
      final key =
          DateTime(a.startTime.year, a.startTime.month, a.startTime.day);
      (map[key] ??= []).add(a);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final apptAsync = ref.watch(_appointmentsProvider);
    final appts = apptAsync.valueOrNull ?? [];
    final eventMap = _buildEventMap(appts);
    final selectedKey = DateTime(
        _selectedDay.year, _selectedDay.month, _selectedDay.day);
    final selectedAppts = eventMap[selectedKey] ?? [];

    return Column(
      children: [
        TableCalendar<Appointment>(
          firstDay: DateTime(2000),
          lastDay: DateTime(2100, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          eventLoader: (day) =>
              eventMap[DateTime(day.year, day.month, day.day)] ?? [],
          calendarFormat: CalendarFormat.month,
          onDaySelected: (selected, focused) {
            setState(() {
              _selectedDay = selected;
              _focusedDay = focused;
            });
          },
          onPageChanged: (focused) => setState(() => _focusedDay = focused),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (_, day, events) {
              if (events.isEmpty) return null;
              return Positioned(
                bottom: 4,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: events
                      .take(3)
                      .map((_) => Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              color: TraumColors.coralOrange,
                              shape: BoxShape.circle,
                            ),
                          ))
                      .toList(),
                ),
              );
            },
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: TraumColors.coralOrange.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            selectedDecoration: const BoxDecoration(
              color: TraumColors.coralOrange,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SectionHeader(
                title:
                    'Termine am ${_selectedDay.day}.${_selectedDay.month}.',
              ),
              const SizedBox(height: 8),
              if (selectedAppts.isEmpty)
                Text(
                  'Keine Termine',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: TraumColors.onBackgroundMuted,
                      ),
                )
              else
                ...selectedAppts.map(
                  (a) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Dismissible(
                      key: ValueKey(a.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => ref
                          .read(planningRepositoryProvider)
                          .deleteAppointment(a.id),
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.delete_rounded,
                            color: Colors.red),
                      ),
                      child: AppointmentChip(
                        time: traum_dates.formatTime(a.startTime),
                        title: a.title,
                        accentColor: a.color != null
                            ? Color(a.color!)
                            : TraumColors.coralOrange,
                      ),
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
              FilterChip(
                label: const Text('Alle'),
                selected: _filterDone == null,
                onSelected: (_) => setState(() => _filterDone = null),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Offen'),
                selected: _filterDone == false,
                onSelected: (_) => setState(() => _filterDone = false),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Erledigt'),
                selected: _filterDone == true,
                onSelected: (_) => setState(() => _filterDone = true),
              ),
            ],
          ),
        ),
        Expanded(
          child: todosAsync.when(
            data: (todos) {
              final filtered = _filterDone == null
                  ? todos
                  : todos.where((t) => t.done == _filterDone).toList();
              if (filtered.isEmpty) {
                return Center(
                  child: Text(
                    'Keine Todos',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: TraumColors.onBackgroundMuted,
                        ),
                  ),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final t = filtered[i];
                  return Dismissible(
                    key: ValueKey(t.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) =>
                        ref.read(planningRepositoryProvider).deleteTodo(t.id),
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:
                          const Icon(Icons.delete_rounded, color: Colors.red),
                    ),
                    child: TraumCard(
                      child: CheckboxListTile(
                        title: Text(
                          t.title,
                          style: TextStyle(
                            decoration:
                                t.done ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: t.dueDate != null
                            ? Text(
                                '${t.dueDate!.day}.${t.dueDate!.month}.${t.dueDate!.year}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: t.dueDate!
                                                  .isBefore(DateTime.now()) &&
                                              !t.done
                                          ? Colors.red
                                          : TraumColors.onBackgroundMuted,
                                    ),
                              )
                            : (t.note != null ? Text(t.note!) : null),
                        secondary: t.priority > 0
                            ? Icon(
                                Icons.flag_rounded,
                                color: t.priority >= 2
                                    ? Colors.red
                                    : Colors.orange,
                                size: 18,
                              )
                            : null,
                        value: t.done,
                        onChanged: (v) => ref
                            .read(planningRepositoryProvider)
                            .updateTodo(t.copyWith(done: v ?? false)),
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
        if (goals.isEmpty) {
          return Center(
            child: Text(
              'Noch keine Ziele',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: TraumColors.onBackgroundMuted),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: goals.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, i) {
            final g = goals[i];
            final pct = (g.targetValue != null && g.targetValue! > 0)
                ? (g.currentValue / g.targetValue!).clamp(0.0, 1.0)
                : 0.0;
            return Dismissible(
              key: ValueKey(g.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) =>
                  ref.read(planningRepositoryProvider).deleteGoal(g.id),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.delete_rounded, color: Colors.red),
              ),
              child: TraumCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(g.title,
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          if (g.done)
                            const Icon(Icons.check_circle_rounded,
                                color: TraumColors.success),
                        ],
                      ),
                      if (g.description != null) ...[
                        const SizedBox(height: 4),
                        Text(g.description!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: TraumColors.onBackgroundMuted)),
                      ],
                      const SizedBox(height: 8),
                      GradientProgressBar(
                          value: pct.toDouble(),
                          gradient: TraumColors.gradientCool,
                          height: 6),
                      const SizedBox(height: 4),
                      Text(
                        '${g.currentValue} / ${g.targetValue ?? '?'} ${g.unit ?? ''}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: TraumColors.onBackgroundMuted),
                      ),
                      if (g.targetDate != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Deadline: ${g.targetDate!.day}.${g.targetDate!.month}.${g.targetDate!.year}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: TraumColors.onBackgroundSubtle),
                        ),
                      ],
                    ],
                  ),
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
        if (habits.isEmpty) {
          return Center(
            child: Text(
              'Noch keine Gewohnheiten',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: TraumColors.onBackgroundMuted),
            ),
          );
        }
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
            final doneDates = habitLogs
                .where((l) => l.done)
                .map((l) => l.logDate)
                .toList();
            final streak = calculateStreak(doneDates);
            final weekDone = List.generate(7, (d) {
              final day = weekStart.add(Duration(days: d));
              return habitLogs.any(
                  (l) => traum_dates.isSameDay(l.logDate, day) && l.done);
            });

            return Dismissible(
              key: ValueKey(h.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) =>
                  ref.read(planningRepositoryProvider).deleteHabit(h.id),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.delete_rounded, color: Colors.red),
              ),
              child: TraumCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (h.emoji != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(h.emoji!,
                                  style: const TextStyle(fontSize: 20)),
                            ),
                          Expanded(
                            child: Text(h.name,
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          Text(
                            _freqLabel(h.frequency),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: TraumColors.onBackgroundMuted),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      HabitWeekRow(
                        streak: streak,
                        days: weekDone,
                        onDayTap: (dayIndex) async {
                          final day =
                              weekStart.add(Duration(days: dayIndex));
                          final isDone = weekDone[dayIndex];
                          if (isDone) {
                            await ref
                                .read(planningRepositoryProvider)
                                .deleteHabitLog(h.id, day);
                          } else {
                            await ref
                                .read(planningRepositoryProvider)
                                .insertHabitLog(
                                  HabitLogsCompanion.insert(
                                      habitId: h.id, logDate: day),
                                );
                          }
                        },
                      ),
                    ],
                  ),
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

  String _freqLabel(String f) => switch (f) {
        'daily' => 'Täglich',
        'weekly' => 'Wöchentlich',
        'monthly' => 'Monatlich',
        _ => f,
      };
}

// ── Add Appointment Sheet ─────────────────────────────────────────────────────
class _AddAppointmentSheet extends ConsumerStatefulWidget {
  const _AddAppointmentSheet();

  @override
  ConsumerState<_AddAppointmentSheet> createState() =>
      _AddAppointmentSheetState();
}

class _AddAppointmentSheetState extends ConsumerState<_AddAppointmentSheet> {
  final _titleCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  DateTime _date = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay? _endTime;
  bool _allDay = false;
  int? _colorValue;
  String _recurrence = 'none';

  static const _colors = <int?>[
    null,
    0xFFE57373,
    0xFF81C784,
    0xFF64B5F6,
    0xFFFFD54F,
    0xFFCE93D8,
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _locationCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _SheetHeader(title: 'Termin hinzufügen'),
            const SizedBox(height: 16),
            TextField(
              controller: _titleCtrl,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Titel *'),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Datum: ${_date.day}.${_date.month}.${_date.year}',
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: const Icon(Icons.calendar_today_rounded,
                  color: Colors.white38),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100, 12, 31),
                );
                if (d != null) setState(() => _date = d);
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Ganztägig',
                  style: TextStyle(color: Colors.white70)),
              value: _allDay,
              onChanged: (v) => setState(() => _allDay = v),
            ),
            if (!_allDay) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Startzeit: ${_startTime.format(context)}',
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: const Icon(Icons.access_time_rounded,
                    color: Colors.white38),
                onTap: () async {
                  final t = await showTimePicker(
                      context: context, initialTime: _startTime);
                  if (t != null) setState(() => _startTime = t);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Endzeit: ${_endTime?.format(context) ?? "Optional"}',
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: const Icon(Icons.access_time_rounded,
                    color: Colors.white38),
                onTap: () async {
                  final t = await showTimePicker(
                      context: context,
                      initialTime: _endTime ?? _startTime);
                  if (t != null) setState(() => _endTime = t);
                },
              ),
            ],
            const SizedBox(height: 4),
            TextField(
              controller: _locationCtrl,
              decoration:
                  const InputDecoration(labelText: 'Ort (optional)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descCtrl,
              maxLines: 2,
              decoration:
                  const InputDecoration(labelText: 'Notizen (optional)'),
            ),
            const SizedBox(height: 16),
            const Text('Farbe',
                style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              children: _colors.map((c) {
                return GestureDetector(
                  onTap: () => setState(() => _colorValue = c),
                  child: Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: c == null ? Colors.white12 : Color(c),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _colorValue == c
                            ? Colors.white
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: c == null
                        ? const Icon(Icons.block_rounded,
                            color: Colors.white38, size: 14)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _recurrence,
              decoration:
                  const InputDecoration(labelText: 'Wiederholung'),
              dropdownColor: const Color(0xFF1A1D23),
              items: const [
                DropdownMenuItem(value: 'none', child: Text('Keine')),
                DropdownMenuItem(value: 'daily', child: Text('Täglich')),
                DropdownMenuItem(
                    value: 'weekly', child: Text('Wöchentlich')),
                DropdownMenuItem(
                    value: 'monthly', child: Text('Monatlich')),
                DropdownMenuItem(
                    value: 'yearly', child: Text('Jährlich')),
              ],
              onChanged: (v) => setState(() => _recurrence = v ?? 'none'),
            ),
            const SizedBox(height: 24),
            _SaveButton(onSave: _save),
          ],
        ),
      ),
    );
  }

  void _save() {
    if (_titleCtrl.text.trim().isEmpty) return;
    final start = _allDay
        ? DateTime(_date.year, _date.month, _date.day)
        : DateTime(_date.year, _date.month, _date.day,
            _startTime.hour, _startTime.minute);
    final end = !_allDay && _endTime != null
        ? DateTime(_date.year, _date.month, _date.day,
            _endTime!.hour, _endTime!.minute)
        : null;
    ref.read(planningRepositoryProvider).insertAppointment(
          AppointmentsCompanion(
            title: Value(_titleCtrl.text.trim()),
            startTime: Value(start),
            endTime: Value(end),
            allDay: Value(_allDay),
            location: Value(_locationCtrl.text.trim().isEmpty
                ? null
                : _locationCtrl.text.trim()),
            description: Value(_descCtrl.text.trim().isEmpty
                ? null
                : _descCtrl.text.trim()),
            recurrenceRule:
                Value(_recurrence == 'none' ? null : _recurrence),
            color: Value(_colorValue),
          ),
        );
    Navigator.pop(context);
  }
}

// ── Add Todo Sheet ────────────────────────────────────────────────────────────
class _AddTodoSheet extends ConsumerStatefulWidget {
  const _AddTodoSheet();

  @override
  ConsumerState<_AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends ConsumerState<_AddTodoSheet> {
  final _titleCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  DateTime? _dueDate;
  int _priority = 0;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _SheetHeader(title: 'Todo hinzufügen'),
            const SizedBox(height: 16),
            TextField(
              controller: _titleCtrl,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Titel *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteCtrl,
              decoration: const InputDecoration(
                  labelText: 'Notiz / Kategorie (optional)'),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                _dueDate != null
                    ? 'Fällig: ${_dueDate!.day}.${_dueDate!.month}.${_dueDate!.year}'
                    : 'Fälligkeitsdatum (optional)',
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_dueDate != null)
                    IconButton(
                      icon: const Icon(Icons.clear_rounded,
                          color: Colors.white38),
                      onPressed: () => setState(() => _dueDate = null),
                    ),
                  const Icon(Icons.calendar_today_rounded,
                      color: Colors.white38),
                ],
              ),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _dueDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100, 12, 31),
                );
                if (d != null) setState(() => _dueDate = d);
              },
            ),
            const SizedBox(height: 8),
            const Text('Priorität',
                style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Keine')),
                ButtonSegment(value: 1, label: Text('Niedrig')),
                ButtonSegment(value: 2, label: Text('Hoch')),
              ],
              selected: {_priority},
              onSelectionChanged: (s) =>
                  setState(() => _priority = s.first),
            ),
            const SizedBox(height: 24),
            _SaveButton(onSave: _save),
          ],
        ),
      ),
    );
  }

  void _save() {
    if (_titleCtrl.text.trim().isEmpty) return;
    ref.read(planningRepositoryProvider).insertTodo(
          TodosCompanion(
            title: Value(_titleCtrl.text.trim()),
            note: Value(_noteCtrl.text.trim().isEmpty
                ? null
                : _noteCtrl.text.trim()),
            priority: Value(_priority),
            dueDate: Value(_dueDate),
          ),
        );
    Navigator.pop(context);
  }
}

// ── Add Goal Sheet ────────────────────────────────────────────────────────────
class _AddGoalSheet extends ConsumerStatefulWidget {
  const _AddGoalSheet();

  @override
  ConsumerState<_AddGoalSheet> createState() => _AddGoalSheetState();
}

class _AddGoalSheetState extends ConsumerState<_AddGoalSheet> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _targetCtrl = TextEditingController();
  final _currentCtrl = TextEditingController(text: '0');
  final _unitCtrl = TextEditingController();
  DateTime? _deadline;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _targetCtrl.dispose();
    _currentCtrl.dispose();
    _unitCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _SheetHeader(title: 'Ziel hinzufügen'),
            const SizedBox(height: 16),
            TextField(
              controller: _titleCtrl,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Titel *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descCtrl,
              maxLines: 2,
              decoration: const InputDecoration(
                  labelText: 'Beschreibung (optional)'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _currentCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Aktuell'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _targetCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Ziel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _unitCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Einheit'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                _deadline != null
                    ? 'Deadline: ${_deadline!.day}.${_deadline!.month}.${_deadline!.year}'
                    : 'Deadline (optional)',
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_deadline != null)
                    IconButton(
                      icon: const Icon(Icons.clear_rounded,
                          color: Colors.white38),
                      onPressed: () => setState(() => _deadline = null),
                    ),
                  const Icon(Icons.calendar_today_rounded,
                      color: Colors.white38),
                ],
              ),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _deadline ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100, 12, 31),
                );
                if (d != null) setState(() => _deadline = d);
              },
            ),
            const SizedBox(height: 24),
            _SaveButton(onSave: _save),
          ],
        ),
      ),
    );
  }

  void _save() {
    if (_titleCtrl.text.trim().isEmpty) return;
    ref.read(planningRepositoryProvider).insertGoal(
          GoalsCompanion(
            title: Value(_titleCtrl.text.trim()),
            description: Value(_descCtrl.text.trim().isEmpty
                ? null
                : _descCtrl.text.trim()),
            targetValue: Value(int.tryParse(_targetCtrl.text.trim())),
            currentValue:
                Value(int.tryParse(_currentCtrl.text.trim()) ?? 0),
            unit: Value(_unitCtrl.text.trim().isEmpty
                ? null
                : _unitCtrl.text.trim()),
            targetDate: Value(_deadline),
          ),
        );
    Navigator.pop(context);
  }
}

// ── Add Habit Sheet ───────────────────────────────────────────────────────────
class _AddHabitSheet extends ConsumerStatefulWidget {
  const _AddHabitSheet();

  @override
  ConsumerState<_AddHabitSheet> createState() => _AddHabitSheetState();
}

class _AddHabitSheetState extends ConsumerState<_AddHabitSheet> {
  final _nameCtrl = TextEditingController();
  String? _selectedEmoji;
  String _frequency = 'daily';

  static const _emojis = [
    '🏃', '💪', '📚', '💤', '🥗', '🧘', '🚴',
    '🎵', '✍️', '🧹', '💧', '🌟', '🏋️', '🎯',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _SheetHeader(title: 'Gewohnheit hinzufügen'),
            const SizedBox(height: 16),
            TextField(
              controller: _nameCtrl,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Name *'),
            ),
            const SizedBox(height: 16),
            const Text('Emoji',
                style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _emojis.map((e) {
                final selected = _selectedEmoji == e;
                return GestureDetector(
                  onTap: () => setState(
                      () => _selectedEmoji = selected ? null : e),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: selected
                          ? TraumColors.coralOrange.withValues(alpha: 0.2)
                          : Colors.white12,
                      borderRadius: BorderRadius.circular(8),
                      border: selected
                          ? Border.all(
                              color: TraumColors.coralOrange, width: 1.5)
                          : null,
                    ),
                    child: Center(
                      child:
                          Text(e, style: const TextStyle(fontSize: 22)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Häufigkeit',
                style: TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'daily', label: Text('Täglich')),
                ButtonSegment(
                    value: 'weekly', label: Text('Wöchentlich')),
                ButtonSegment(
                    value: 'monthly', label: Text('Monatlich')),
              ],
              selected: {_frequency},
              onSelectionChanged: (s) =>
                  setState(() => _frequency = s.first),
            ),
            const SizedBox(height: 24),
            _SaveButton(onSave: _save),
          ],
        ),
      ),
    );
  }

  void _save() {
    if (_nameCtrl.text.trim().isEmpty) return;
    ref.read(planningRepositoryProvider).insertHabit(
          HabitsCompanion(
            name: Value(_nameCtrl.text.trim()),
            emoji: Value(_selectedEmoji),
            frequency: Value(_frequency),
          ),
        );
    Navigator.pop(context);
  }
}

// ── Shared helpers ────────────────────────────────────────────────────────────
class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white54),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.onSave});
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: TraumColors.coralOrange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onSave,
        child: const Text('Speichern',
            style:
                TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
