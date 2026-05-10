import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/theme/colors.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(preferencesRepositoryProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Einstellungen')),
      body: ListView(
        children: [
          // Appearance
          _SectionHeader('Erscheinungsbild'),
          ListTile(
            title: const Text('Design'),
            trailing: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode_rounded), label: Text('Dunkel')),
                ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode_rounded), label: Text('Hell')),
                ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.settings_brightness_rounded), label: Text('Auto')),
              ],
              selected: {themeMode},
              onSelectionChanged: (s) async {
                final modeStr = switch (s.first) {
                  ThemeMode.dark => 'dark',
                  ThemeMode.light => 'light',
                  _ => 'system',
                };
                await ref.read(themeProvider.notifier).setTheme(modeStr);
              },
            ),
          ),
          // Language
          _SectionHeader('Sprache'),
          ListTile(
            title: const Text('App-Sprache'),
            subtitle: Text(ref.watch(localeProvider)?.languageCode ?? 'Systemsprache'),
            trailing: const Icon(Icons.language_rounded),
            onTap: () => _showLanguagePicker(context, ref),
          ),
          // Units
          _SectionHeader('Einheiten'),
          ListTile(
            title: const Text('Maßsystem'),
            trailing: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'metric', label: Text('Metrisch')),
                ButtonSegment(value: 'imperial', label: Text('Imperial')),
              ],
              selected: {prefs.unitSystem},
              onSelectionChanged: (s) => prefs.setUnitSystem(s.first),
            ),
          ),
          // Notifications
          _SectionHeader('Benachrichtigungen'),
          SwitchListTile(
            title: const Text('Medikamenten-Erinnerung'),
            value: prefs.notifMedication,
            onChanged: (v) => prefs.setNotifMedication(v),
          ),
          SwitchListTile(
            title: const Text('Supplement-Erinnerung'),
            value: prefs.notifSupplement,
            onChanged: (v) => prefs.setNotifSupplement(v),
          ),
          SwitchListTile(
            title: const Text('Training-Erinnerung'),
            value: prefs.notifWorkout,
            onChanged: (v) => prefs.setNotifWorkout(v),
          ),
          SwitchListTile(
            title: const Text('Wasser-Erinnerung'),
            value: prefs.notifWater,
            onChanged: (v) => prefs.setNotifWater(v),
          ),
          SwitchListTile(
            title: const Text('Todo-Fälligkeiten'),
            value: prefs.notifTodo,
            onChanged: (v) => prefs.setNotifTodo(v),
          ),
          SwitchListTile(
            title: const Text('Gewohnheiten'),
            value: prefs.notifHabit,
            onChanged: (v) => prefs.setNotifHabit(v),
          ),
          SwitchListTile(
            title: const Text('Zykluserinnerungen'),
            value: prefs.notifPeriod,
            onChanged: (v) => prefs.setNotifPeriod(v),
          ),
          // Fitness goals
          _SectionHeader('Ziele'),
          ListTile(
            title: const Text('Schritte/Tag'),
            subtitle: Text('${prefs.stepsGoal}'),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _showIntEdit(context, 'Schritte/Tag', prefs.stepsGoal, 1000, 50000, prefs.setStepsGoal),
          ),
          ListTile(
            title: const Text('Wasserziel (ml)'),
            subtitle: Text('${prefs.waterGoalMl} ml'),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _showIntEdit(context, 'Wasser (ml)', prefs.waterGoalMl, 500, 6000, prefs.setWaterGoalMl),
          ),
          ListTile(
            title: const Text('Kalorienziel (kcal)'),
            subtitle: Text('${prefs.kcalGoal} kcal'),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _showIntEdit(context, 'Kalorien', prefs.kcalGoal, 800, 6000, prefs.setKcalGoal),
          ),
          // Period
          _SectionHeader('Zyklus'),
          SwitchListTile(
            title: const Text('Zyklusanalyse aktivieren'),
            value: prefs.isPeriodTrackingEnabled,
            onChanged: (v) => prefs.setIsPeriodTrackingEnabled(v),
          ),
          // Budget
          _SectionHeader('Budget'),
          ListTile(
            title: const Text('Währungssymbol'),
            subtitle: Text(prefs.currencySymbol),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _showStringEdit(context, 'Währungssymbol', prefs.currencySymbol, prefs.setCurrencySymbol),
          ),
          // Account
          _SectionHeader('Konto'),
          ListTile(
            title: const Text('Onboarding zurücksetzen'),
            leading: const Icon(Icons.restart_alt_rounded),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Onboarding zurücksetzen?'),
                  content: const Text('Die App startet beim nächsten Öffnen mit dem Einrichtungsassistenten.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Abbrechen')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Zurücksetzen')),
                  ],
                ),
              );
              if (confirm == true) {
                await prefs.setOnboardingComplete(false);
              }
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    const languages = [
      ('de', 'Deutsch'),
      ('en', 'English'),
      ('zh', '中文'),
      ('hi', 'हिंदी'),
      ('es', 'Español'),
      ('fr', 'Français'),
      ('ar', 'العربية'),
      ('pt', 'Português'),
      ('ru', 'Русский'),
    ];
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Sprache wählen'),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              await ref.read(localeProvider.notifier).clearLocale();
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Systemsprache'),
          ),
          ...languages.map((l) => SimpleDialogOption(
            onPressed: () async {
              await ref.read(localeProvider.notifier).setLocale(l.$1);
              if (context.mounted) Navigator.pop(context);
            },
            child: Text(l.$2),
          )),
        ],
      ),
    );
  }

  void _showIntEdit(BuildContext context, String label, int current, int min, int max, Future<void> Function(int) onSave) {
    final ctrl = TextEditingController(text: '$current');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(label),
        content: TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () async {
              final v = int.tryParse(ctrl.text);
              if (v != null && v >= min && v <= max) {
                await onSave(v);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );
  }

  void _showStringEdit(BuildContext context, String label, String current, Future<void> Function(String) onSave) {
    final ctrl = TextEditingController(text: current);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(label),
        content: TextField(controller: ctrl, decoration: InputDecoration(labelText: label)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () async {
              if (ctrl.text.trim().isNotEmpty) {
                await onSave(ctrl.text.trim());
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('Speichern'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
    child: Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.coralOrange, fontWeight: FontWeight.bold)),
  );
}
