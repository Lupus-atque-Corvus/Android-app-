import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/components.dart';
import '../../core/navigation/routes.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/providers/repository_providers.dart';
import '../../core/services/update_service.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/date_utils.dart' as traum_dates;
import '../../l10n/app_localizations.dart';
import '../../data/database/traum_database.dart';
import 'widgets/clock_weather_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkUpdate());
  }

  Future<void> _checkUpdate() async {
    final info = await UpdateService.checkForUpdate();
    if (info == null || !mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _UpdateDialog(info: info),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 12),
                  const HomeClockWeatherWidget(),
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

// ── Update Dialog ─────────────────────────────────────────────────────────────

class _UpdateDialog extends StatefulWidget {
  const _UpdateDialog({required this.info});
  final UpdateInfo info;

  @override
  State<_UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<_UpdateDialog> {
  bool _downloading = false;
  double? _progress;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xFF0F1115),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: TraumColors.gradientWarm,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.system_update_rounded, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Update verfügbar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Version ${widget.info.latestVersion}',
                        style: const TextStyle(color: TraumColors.coralOrange, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.info.releaseNotes.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    widget.info.releaseNotes,
                    style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                  ),
                ),
              ),
            ],
            if (_downloading) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation<Color>(TraumColors.coralOrange),
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 6),
              Text(
                _progress != null ? '${(_progress! * 100).round()} %' : 'Verbinde…',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _downloading ? null : () => Navigator.pop(context),
                    style: TextButton.styleFrom(foregroundColor: Colors.white38),
                    child: const Text('Später'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _downloading ? null : _download,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: _downloading ? null : TraumColors.gradientWarm,
                        color: _downloading ? Colors.white12 : null,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      alignment: Alignment.center,
                      child: _downloading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white54),
                            )
                          : const Text(
                              'Jetzt aktualisieren',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _download() async {
    setState(() { _downloading = true; _progress = null; });
    try {
      await UpdateService.downloadAndInstall(
        widget.info.apkDownloadUrl,
        (p) { if (mounted) setState(() => _progress = p); },
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() { _downloading = false; _progress = null; });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download fehlgeschlagen: $e')),
        );
      }
    }
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
