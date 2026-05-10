import 'dart:convert';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart' show Share, XFile;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../../core/notifications/notification_service.dart';
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
          // ── Erscheinungsbild ───────────────────────────────────────────────
          _SectionHeader('Erscheinungsbild'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SegmentedButton<ThemeMode>(
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

          // ── Sprache ────────────────────────────────────────────────────────
          _SectionHeader('Sprache'),
          ListTile(
            title: const Text('App-Sprache'),
            subtitle: Text(ref.watch(localeProvider)?.languageCode ?? 'Systemsprache'),
            trailing: const Icon(Icons.language_rounded),
            onTap: () => _showLanguagePicker(context, ref),
          ),

          // ── Einheiten ──────────────────────────────────────────────────────
          _SectionHeader('Einheiten'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'metric', label: Text('Metrisch')),
                ButtonSegment(value: 'imperial', label: Text('Imperial')),
              ],
              selected: {ref.watch(unitSystemProvider)},
              onSelectionChanged: (s) => prefs.setUnitSystem(s.first),
            ),
          ),

          // ── Benachrichtigungen ─────────────────────────────────────────────
          _SectionHeader('Benachrichtigungen'),
          SwitchListTile(
            title: const Text('Medikamenten-Erinnerung'),
            value: prefs.notifMedication,
            onChanged: (v) async {
              await prefs.setNotifMedication(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: const Text('Supplement-Erinnerung'),
            value: prefs.notifSupplement,
            onChanged: (v) async {
              await prefs.setNotifSupplement(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: const Text('Training-Erinnerung'),
            value: prefs.notifWorkout,
            onChanged: (v) async {
              await prefs.setNotifWorkout(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: const Text('Wasser-Erinnerung'),
            value: prefs.notifWater,
            onChanged: (v) async {
              await prefs.setNotifWater(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: const Text('Todo-Fälligkeiten'),
            value: prefs.notifTodo,
            onChanged: (v) async {
              await prefs.setNotifTodo(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: const Text('Gewohnheiten'),
            value: prefs.notifHabit,
            onChanged: (v) async {
              await prefs.setNotifHabit(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: const Text('Zykluserinnerungen'),
            value: prefs.notifPeriod,
            onChanged: (v) => prefs.setNotifPeriod(v),
          ),

          // ── Ziele ─────────────────────────────────────────────────────────
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

          // ── Datenschutz & Sicherheit ───────────────────────────────────────
          _SectionHeader('Datenschutz & Sicherheit'),
          SwitchListTile(
            title: const Text('Biometrische Sperre'),
            subtitle: const Text('Face ID / Fingerabdruck beim Start'),
            value: prefs.biometricLockEnabled,
            onChanged: (v) => _toggleBiometric(context, prefs, v),
          ),
          ListTile(
            title: const Text('Daten exportieren (JSON)'),
            leading: const Icon(Icons.upload_outlined),
            onTap: () => _exportJson(context),
          ),
          ListTile(
            title: const Text('Backup erstellen (.zip)'),
            leading: const Icon(Icons.backup_outlined),
            onTap: () => _createBackup(context),
          ),

          // ── Wetter ────────────────────────────────────────────────────────
          _SectionHeader('Wetter'),
          ListTile(
            title: const Text('Standort automatisch ermitteln'),
            leading: const Icon(Icons.my_location_rounded),
            onTap: () => _detectLocation(context, prefs),
          ),
          ListTile(
            title: const Text('Koordinaten'),
            subtitle: Text(prefs.weatherLat != null
                ? '${prefs.weatherLat!.toStringAsFixed(4)}, ${prefs.weatherLon?.toStringAsFixed(4)}'
                : 'Nicht gesetzt'),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _showWeatherEdit(context, prefs),
          ),

          // ── Navigation ────────────────────────────────────────────────────
          _SectionHeader('Navigation (5 Slots)'),
          _NavSlotsEditor(prefs: prefs),

          // ── Zyklus ────────────────────────────────────────────────────────
          _SectionHeader('Zyklus'),
          SwitchListTile(
            title: const Text('Zyklusanalyse aktivieren'),
            value: prefs.isPeriodTrackingEnabled,
            onChanged: (v) => prefs.setIsPeriodTrackingEnabled(v),
          ),

          // ── Budget ────────────────────────────────────────────────────────
          _SectionHeader('Budget'),
          ListTile(
            title: const Text('Währungssymbol'),
            subtitle: Text(prefs.currencySymbol),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _showStringEdit(context, 'Währungssymbol', prefs.currencySymbol, prefs.setCurrencySymbol),
          ),

          // ── Homescreen-Widgets ────────────────────────────────────────────
          _SectionHeader('Homescreen-Widgets'),
          const _WidgetGalleryTile(),

          // ── Konto ─────────────────────────────────────────────────────────
          _SectionHeader('Konto'),
          ListTile(
            title: const Text('App-Version'),
            leading: const Icon(Icons.info_outline_rounded),
            trailing: const _VersionText(),
          ),
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
              if (confirm == true) await prefs.setOnboardingComplete(false);
            },
          ),
          ListTile(
            title: const Text('Alle Daten löschen', style: TextStyle(color: TraumColors.error)),
            leading: const Icon(Icons.delete_forever_rounded, color: TraumColors.error),
            onTap: () => _deleteAllData(context, prefs),
          ),

          // ── Support ───────────────────────────────────────────────────────
          _SectionHeader('Support'),
          ListTile(
            title: const Text('Fehler melden'),
            leading: const Icon(Icons.bug_report_outlined),
            onTap: _sendFeedbackMail,
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Future<void> _reschedule(dynamic prefs) async {
    await NotificationService.rescheduleAll(NotificationPrefsSnapshot(
      medicationEnabled: prefs.notifMedication,
      supplementEnabled: prefs.notifSupplement,
      workoutEnabled: prefs.notifWorkout,
      habitEnabled: prefs.notifHabit,
      todoEnabled: prefs.notifTodo,
    ));
  }

  Future<void> _toggleBiometric(BuildContext context, dynamic prefs, bool enable) async {
    if (enable) {
      final auth = LocalAuthentication();
      final canAuth = await auth.canCheckBiometrics;
      if (!canAuth) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Biometrie nicht verfügbar auf diesem Gerät.')),
          );
        }
        return;
      }
      final ok = await auth.authenticate(localizedReason: 'Biometrische Sperre aktivieren');
      if (!ok) return;
    }
    await prefs.setBiometricLockEnabled(enable);
  }

  Future<void> _exportJson(BuildContext context) async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/traum_export_${DateTime.now().millisecondsSinceEpoch}.json');
      await file.writeAsString(jsonEncode({'exported': DateTime.now().toIso8601String(), 'note': 'TRAUM data export'}));
      await Share.shareXFiles([XFile(file.path)], subject: 'TRAUM Datenexport');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Export fehlgeschlagen: $e')));
      }
    }
  }

  Future<void> _createBackup(BuildContext context) async {
    try {
      final dir = await getTemporaryDirectory();
      final archive = Archive();
      archive.addFile(ArchiveFile('backup_info.txt', 0, utf8.encode('TRAUM backup ${DateTime.now().toIso8601String()}')));
      final zipBytes = ZipEncoder().encode(archive)!;
      final zipFile = File('${dir.path}/traum_backup_${DateTime.now().millisecondsSinceEpoch}.zip');
      await zipFile.writeAsBytes(zipBytes);
      await Share.shareXFiles([XFile(zipFile.path)], subject: 'TRAUM Backup');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Backup fehlgeschlagen: $e')));
      }
    }
  }

  Future<void> _detectLocation(BuildContext context, dynamic prefs) async {
    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Standortzugriff verweigert.')));
        }
        return;
      }
      final pos = await Geolocator.getCurrentPosition();
      await prefs.setWeatherLocation(pos.latitude, pos.longitude);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Standort gespeichert: ${pos.latitude.toStringAsFixed(4)}, ${pos.longitude.toStringAsFixed(4)}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fehler: $e')));
      }
    }
  }

  Future<void> _deleteAllData(BuildContext context, dynamic prefs) async {
    final first = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Alle Daten löschen?'),
        content: const Text('Dies löscht alle lokalen Daten dauerhaft. Diese Aktion kann nicht rückgängig gemacht werden.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: TraumColors.error),
            child: const Text('Weiter'),
          ),
        ],
      ),
    );
    if (first != true || !context.mounted) return;
    final second = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Wirklich alle Daten löschen?'),
        content: const Text('Letzte Warnung: Alle Einträge, Ziele, Protokolle und Einstellungen werden gelöscht.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: TraumColors.error),
            child: const Text('Alles löschen'),
          ),
        ],
      ),
    );
    if (second != true) return;
    await prefs.clearAll();
  }

  Future<void> _sendFeedbackMail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@traum-app.de',
      queryParameters: {
        'subject': 'TRAUM App – Fehlerreport',
        'body': 'Beschreibe den Fehler hier:\n\n\n\nApp-Version: \nGerät: \nAndroid/iOS: ',
      },
    );
    await launchUrl(uri);
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    const languages = [
      ('de', 'Deutsch'), ('en', 'English'), ('zh', '中文'), ('hi', 'हिंदी'),
      ('es', 'Español'), ('fr', 'Français'), ('ar', 'العربية'), ('pt', 'Português'), ('ru', 'Русский'),
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
        content: TextField(controller: ctrl, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: label)),
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

  void _showWeatherEdit(BuildContext context, dynamic prefs) {
    final latCtrl = TextEditingController(text: prefs.weatherLat?.toStringAsFixed(4) ?? '');
    final lonCtrl = TextEditingController(text: prefs.weatherLon?.toStringAsFixed(4) ?? '');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Wetterkoordinaten'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: latCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(labelText: 'Breitengrad'),
            ),
            TextField(
              controller: lonCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(labelText: 'Längengrad'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Abbrechen')),
          TextButton(
            onPressed: () async {
              final lat = double.tryParse(latCtrl.text);
              final lon = double.tryParse(lonCtrl.text);
              if (lat != null && lon != null) {
                await prefs.setWeatherLocation(lat, lon);
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

// ── Nav Slots ReorderableListView ───────────────────────────────────────────

class _NavSlotsEditor extends ConsumerWidget {
  const _NavSlotsEditor({required this.prefs});
  final dynamic prefs;

  static const _allModules = [
    ('home', 'Start', Icons.home_rounded),
    ('training', 'Training', Icons.fitness_center_rounded),
    ('health', 'Gesundheit', Icons.favorite_rounded),
    ('nutrition', 'Ernährung', Icons.restaurant_rounded),
    ('planning', 'Planung', Icons.calendar_today_rounded),
    ('supplements', 'Supplemente', Icons.medication_liquid_rounded),
    ('medication', 'Medikamente', Icons.medication_rounded),
    ('abstinence', 'Abstinenz', Icons.self_improvement_rounded),
    ('budget', 'Budget', Icons.account_balance_wallet_rounded),
    ('period', 'Zyklus', Icons.circle_rounded),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slots = ref.watch(navSlotsProvider);
    final displaySlots = slots.take(5).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reihenfolge der 5 Slots (ziehen zum Sortieren):', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          SizedBox(
            height: 280,
            child: ReorderableListView(
              onReorder: (oldIndex, newIndex) async {
                if (newIndex > oldIndex) newIndex--;
                final updated = List<String>.from(displaySlots);
                final item = updated.removeAt(oldIndex);
                updated.insert(newIndex, item);
                await prefs.setNavSlots(jsonEncode(updated));
              },
              children: [
                for (final slot in displaySlots)
                  Builder(
                    key: ValueKey(slot),
                    builder: (_) {
                      final info = _allModules.firstWhere(
                        (m) => m.$1 == slot,
                        orElse: () => (slot, slot, Icons.widgets_rounded),
                      );
                      return ListTile(
                        leading: Icon(info.$3, color: TraumColors.coralOrange),
                        title: Text(info.$2),
                        trailing: const Icon(Icons.drag_handle_rounded, color: Colors.grey),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Widget Gallery ──────────────────────────────────────────────────────────

class _WidgetGalleryTile extends StatelessWidget {
  const _WidgetGalleryTile();

  @override
  Widget build(BuildContext context) {
    const widgets = [
      ('Übersicht', Icons.dashboard_rounded),
      ('Schritte', Icons.directions_walk_rounded),
      ('Todo', Icons.checklist_rounded),
      ('Abstinenz', Icons.self_improvement_rounded),
      ('Periode', Icons.circle_rounded),
      ('Gesundheit', Icons.favorite_rounded),
      ('Kalender', Icons.event_rounded),
      ('Budget', Icons.account_balance_wallet_rounded),
      ('Ernährung', Icons.restaurant_rounded),
      ('Gewohnheiten', Icons.check_circle_rounded),
      ('Medikamente', Icons.medication_rounded),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Homescreen gedrückt halten → Widget → TRAUM → gewünschtes Widget auswählen.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widgets.map((w) => Chip(
              avatar: Icon(w.$2, size: 16, color: TraumColors.coralOrange),
              label: Text(w.$1),
              backgroundColor: TraumColors.surface,
            )).toList(),
          ),
        ],
      ),
    );
  }
}

// ── App Version ─────────────────────────────────────────────────────────────

class _VersionText extends StatefulWidget {
  const _VersionText();
  @override
  State<_VersionText> createState() => _VersionTextState();
}

class _VersionTextState extends State<_VersionText> {
  String _version = '…';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _version = '${info.version} (${info.buildNumber})');
    });
  }

  @override
  Widget build(BuildContext context) => Text(_version, style: const TextStyle(color: Colors.grey));
}

// ── Section Header ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
    child: Text(
      title,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: TraumColors.coralOrange, fontWeight: FontWeight.bold),
    ),
  );
}
