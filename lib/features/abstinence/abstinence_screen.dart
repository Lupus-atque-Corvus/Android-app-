import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import '../../core/components/components.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/formatters.dart';
import '../../data/database/traum_database.dart';

final _trackersProvider = StreamProvider<List<AbstinenceTracker>>((ref) {
  return ref.watch(abstinenceRepositoryProvider).watchTrackers();
});

class AbstinenceScreen extends ConsumerWidget {
  const AbstinenceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackersAsync = ref.watch(_trackersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Abstinenz')),
      body: trackersAsync.when(
        data: (trackers) => trackers.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.self_improvement_rounded, size: 64, color: TraumColors.onBackgroundSubtle),
                    const SizedBox(height: 16),
                    Text('Noch keine Tracker', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TraumColors.onBackgroundMuted)),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: trackers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _TrackerCard(tracker: trackers[i]),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final emojiCtrl = TextEditingController(text: '🚫');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tracker hinzufügen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name (z.B. Rauchen, Alkohol)')),
            const SizedBox(height: 8),
            TextField(controller: emojiCtrl, decoration: const InputDecoration(labelText: 'Emoji')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () async {
              if (nameCtrl.text.trim().isEmpty) return;
              await ref.read(abstinenceRepositoryProvider).insertTracker(
                    AbstinenceTrackersCompanion.insert(
                      name: nameCtrl.text.trim(),
                      emoji: Value(emojiCtrl.text.trim().isEmpty ? null : emojiCtrl.text.trim()),
                      startDate: DateTime.now(),
                      isActive: const Value(true),
                    ),
                  );
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Erstellen'),
          ),
        ],
      ),
    );
  }
}

class _TrackerCard extends ConsumerStatefulWidget {
  const _TrackerCard({required this.tracker});
  final AbstinenceTracker tracker;

  @override
  ConsumerState<_TrackerCard> createState() => _TrackerCardState();
}

class _TrackerCardState extends ConsumerState<_TrackerCard> {
  late Timer _timer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateElapsed();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateElapsed());
  }

  void _updateElapsed() {
    setState(() {
      _elapsed = DateTime.now().difference(widget.tracker.startDate);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.tracker;

    return TraumCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(t.emoji ?? '🚫', style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.name, style: Theme.of(context).textTheme.titleLarge),
                      Text(
                        'Seit ${t.startDate.day}.${t.startDate.month}.${t.startDate.year}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.onBackgroundMuted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Live elapsed time
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: TraumColors.cyanDim,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  formatElapsed(_elapsed),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: TraumColors.cyanBlue),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showRelapseDialog(context),
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('Rückfall'),
                    style: OutlinedButton.styleFrom(foregroundColor: TraumColors.error, side: const BorderSide(color: TraumColors.error)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showEventsDialog(context),
                    icon: const Icon(Icons.bar_chart_rounded, size: 18),
                    label: const Text('Verlauf'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showRelapseDialog(BuildContext context) {
    final noteCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Rückfall bestätigen'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Der Timer wird auf jetzt zurückgesetzt.'),
            const SizedBox(height: 12),
            TextField(controller: noteCtrl, decoration: const InputDecoration(labelText: 'Notiz (optional)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () async {
              final now = DateTime.now();
              await ref.read(abstinenceRepositoryProvider).insertEvent(
                    AbstinenceEventsCompanion.insert(
                      trackerId: widget.tracker.id,
                      type: 'relapse',
                      eventDate: now,
                      note: Value(noteCtrl.text.trim().isEmpty ? null : noteCtrl.text.trim()),
                    ),
                  );
              // Reset startDate
              await ref.read(abstinenceRepositoryProvider).updateTracker(
                    widget.tracker.copyWith(startDate: now),
                  );
              if (context.mounted) Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: TraumColors.error),
            child: const Text('Rückfall'),
          ),
        ],
      ),
    );
  }

  void _showEventsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Verlauf: ${widget.tracker.name}'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: Consumer(
            builder: (context, ref, _) {
              final eventsAsync = ref.watch(StreamProvider<List<AbstinenceEvent>>((ref) {
                return ref.watch(abstinenceRepositoryProvider).watchEventsForTracker(widget.tracker.id);
              }));
              return eventsAsync.when(
                data: (events) => events.isEmpty
                    ? const Center(child: Text('Keine Ereignisse'))
                    : ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (_, i) {
                          final e = events[i];
                          return ListTile(
                            leading: Icon(e.type == 'relapse' ? Icons.refresh_rounded : Icons.check_circle_rounded,
                                color: e.type == 'relapse' ? TraumColors.error : TraumColors.success),
                            title: Text(e.type == 'relapse' ? 'Rückfall' : 'Meilenstein'),
                            subtitle: Text('${e.eventDate.day}.${e.eventDate.month}.${e.eventDate.year}'),
                          );
                        },
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text(e.toString())),
              );
            },
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Schließen'))],
      ),
    );
  }
}
