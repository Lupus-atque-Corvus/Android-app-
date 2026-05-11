import 'dart:convert';
import 'package:archive/archive_io.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:open_file/open_file.dart';
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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        children: [
          // ── App-Update ─────────────────────────────────────────────────────
          _SectionHeader('App-Update'),
          const _UpdateCheckerTile(),

          // ── Erscheinungsbild ───────────────────────────────────────────────
          _SectionHeader(l10n.settingsAppearance),
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
          _SectionHeader(l10n.settingsLanguage),
          ListTile(
            title: Text(l10n.settingsLanguage),
            subtitle: Text(ref.watch(localeProvider)?.languageCode ?? 'Systemsprache'),
            trailing: const Icon(Icons.language_rounded),
            onTap: () => _showLanguagePicker(context, ref),
          ),

          // ── Einheiten ──────────────────────────────────────────────────────
          _SectionHeader(l10n.settingsUnits),
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
          _SectionHeader(l10n.settingsNotifications),
          SwitchListTile(
            title: Text(l10n.notifMedication),
            value: prefs.notifMedication,
            onChanged: (v) async {
              await prefs.setNotifMedication(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: Text(l10n.notifSupplement),
            value: prefs.notifSupplement,
            onChanged: (v) async {
              await prefs.setNotifSupplement(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: Text(l10n.notifWorkout),
            value: prefs.notifWorkout,
            onChanged: (v) async {
              await prefs.setNotifWorkout(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: Text(l10n.notifWater),
            value: prefs.notifWater,
            onChanged: (v) async {
              await prefs.setNotifWater(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: Text(l10n.notifTodo),
            value: prefs.notifTodo,
            onChanged: (v) async {
              await prefs.setNotifTodo(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: Text(l10n.notifHabit),
            value: prefs.notifHabit,
            onChanged: (v) async {
              await prefs.setNotifHabit(v);
              await _reschedule(prefs);
            },
          ),
          SwitchListTile(
            title: Text(l10n.notifPeriod),
            value: prefs.notifPeriod,
            onChanged: (v) => prefs.setNotifPeriod(v),
          ),

          // ── Ziele ─────────────────────────────────────────────────────────
          _SectionHeader(l10n.planningGoals),
          ListTile(
            title: const Text('Schritte/Tag'),
            subtitle: Text('${prefs.stepsGoal}'),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _showIntEdit(context, 'Schritte/Tag', prefs.stepsGoal, 1000, 50000, prefs.setStepsGoal),
          ),
          ListTile(
            title: Text(l10n.onboardingWaterGoal),
            subtitle: Text('${prefs.waterGoalMl} ml'),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _showIntEdit(context, l10n.onboardingWaterGoal, prefs.waterGoalMl, 500, 6000, prefs.setWaterGoalMl),
          ),
          ListTile(
            title: Text(l10n.onboardingCalorieGoal),
            subtitle: Text('${prefs.kcalGoal} kcal'),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _showIntEdit(context, l10n.onboardingCalorieGoal, prefs.kcalGoal, 800, 6000, prefs.setKcalGoal),
          ),

          // ── Datenschutz & Sicherheit ───────────────────────────────────────
          _SectionHeader(l10n.settingsPrivacy),
          SwitchListTile(
            title: Text(l10n.settingsPinBiometric),
            subtitle: const Text('Face ID / Fingerabdruck beim Start'),
            value: prefs.biometricLockEnabled,
            onChanged: (v) => _toggleBiometric(context, prefs, v),
          ),
          ListTile(
            title: Text(l10n.settingsExportData),
            leading: const Icon(Icons.upload_outlined),
            onTap: () => _exportJson(context),
          ),
          ListTile(
            title: Text(l10n.settingsBackup),
            leading: const Icon(Icons.backup_outlined),
            onTap: () => _createBackup(context),
          ),

          // ── Wetter ────────────────────────────────────────────────────────
          _SectionHeader(l10n.settingsWeather),
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
          _SectionHeader(l10n.settingsNavigation),
          _NavSlotsEditor(prefs: prefs),

          // ── Zyklus ────────────────────────────────────────────────────────
          _SectionHeader(l10n.settingsPeriodTracking),
          SwitchListTile(
            title: Text(l10n.settingsPeriodTracking),
            value: prefs.isPeriodTrackingEnabled,
            onChanged: (v) => prefs.setIsPeriodTrackingEnabled(v),
          ),

          // ── Budget ────────────────────────────────────────────────────────
          _SectionHeader(l10n.budgetTitle),
          ListTile(
            title: const Text('Währungssymbol'),
            subtitle: Text(prefs.currencySymbol),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _showStringEdit(context, 'Währungssymbol', prefs.currencySymbol, prefs.setCurrencySymbol),
          ),

          // ── Homescreen-Widgets ────────────────────────────────────────────
          _SectionHeader(l10n.settingsWidgets),
          const _WidgetGalleryTile(),

          // ── Konto ─────────────────────────────────────────────────────────
          _SectionHeader(l10n.settingsAccount),
          ListTile(
            title: Text(l10n.settingsVersion),
            leading: const Icon(Icons.info_outline_rounded),
            trailing: const _VersionText(),
          ),
          ListTile(
            title: Text(l10n.settingsResetOnboarding),
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
            title: Text(l10n.settingsDeleteAllData, style: const TextStyle(color: TraumColors.error)),
            leading: const Icon(Icons.delete_forever_rounded, color: TraumColors.error),
            onTap: () => _deleteAllData(context, prefs),
          ),

          // ── Support ───────────────────────────────────────────────────────
          _SectionHeader(l10n.settingsSupport),
          ListTile(
            title: Text(l10n.supportBugReport),
            leading: const Icon(Icons.bug_report_outlined),
            onTap: () => _sendFeedbackMail(context, ref),
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

  Future<void> _sendFeedbackMail(BuildContext context, WidgetRef ref) async {
    final info = await PackageInfo.fromPlatform();

    String deviceStr = 'Unbekannt';
    String androidVersionStr = 'Unbekannt';
    int? apiLevel;
    if (Platform.isAndroid) {
      final android = await DeviceInfoPlugin().androidInfo;
      deviceStr = '${android.manufacturer} ${android.model}';
      androidVersionStr = android.version.release;
      apiLevel = android.version.sdkInt;
    }

    final ramGb = _readTotalRamGb();
    final locale = ref.read(localeProvider)?.languageCode ?? 'system';
    final themeStr = switch (ref.read(themeProvider)) {
      ThemeMode.dark => 'Dark',
      ThemeMode.light => 'Light',
      _ => 'System',
    };

    final now = DateTime.now();
    String pad(int n) => n.toString().padLeft(2, '0');

    final sysInfo = StringBuffer()
      ..writeln('---SYSTEMINFO---')
      ..writeln('App-Version: ${info.version} (Build ${info.buildNumber})')
      ..writeln(apiLevel != null
          ? 'Android Version: $androidVersionStr (API $apiLevel)'
          : 'OS: ${Platform.operatingSystemVersion}')
      ..writeln('Gerät: $deviceStr')
      ..write(ramGb != null ? 'RAM: $ramGb GB gesamt\n' : '')
      ..writeln('Sprache: $locale')
      ..writeln('Theme: $themeStr')
      ..write('Datum: ${pad(now.day)}.${pad(now.month)}.${now.year} ${pad(now.hour)}:${pad(now.minute)}');

    final uri = Uri(
      scheme: 'mailto',
      path: 'support@traum-app.de',
      queryParameters: {
        'subject': 'TRAUM Fehlerbericht v${info.version}',
        'body': 'Beschreibe den Fehler hier:\n\n\n\n$sysInfo',
      },
    );
    await launchUrl(uri);
  }

  static int? _readTotalRamGb() {
    try {
      final content = File('/proc/meminfo').readAsStringSync();
      final match = RegExp(r'MemTotal:\s+(\d+)\s+kB').firstMatch(content);
      if (match != null) {
        return (int.parse(match.group(1)!) / (1024 * 1024)).round();
      }
    } catch (_) {}
    return null;
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

// ── Update Checker ───────────────────────────────────────────────────────────

class _UpdateCheckerTile extends StatefulWidget {
  const _UpdateCheckerTile();
  @override
  State<_UpdateCheckerTile> createState() => _UpdateCheckerTileState();
}

class _UpdateCheckerTileState extends State<_UpdateCheckerTile> {
  bool _checking = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.system_update_rounded),
      title: const Text('Nach Updates suchen'),
      trailing: _checking
          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
          : const Icon(Icons.chevron_right_rounded, color: Colors.grey),
      onTap: _checking ? null : _check,
    );
  }

  Future<void> _check() async {
    setState(() => _checking = true);
    try {
      final info = await PackageInfo.fromPlatform();
      final response = await http.get(
        Uri.parse('https://api.github.com/repos/Lupus-atque-Corvus/Android-app-/releases/latest'),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      ).timeout(const Duration(seconds: 10));

      if (!mounted) return;
      if (response.statusCode != 200) {
        _snack('Update-Prüfung fehlgeschlagen (${response.statusCode})');
        return;
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final tag = (data['tag_name'] as String? ?? '').replaceFirst('v', '');

      if (!_isNewer(tag, info.version)) {
        _snack('App ist aktuell (v${info.version})');
        return;
      }

      final assets = (data['assets'] as List<dynamic>?) ?? [];
      final apkAsset = assets
          .cast<Map<String, dynamic>>()
          .where((a) => (a['name'] as String?) == 'app-arm64-v8a-release.apk')
          .firstOrNull;

      if (apkAsset == null) {
        _snack('APK-Datei nicht im Release gefunden.');
        return;
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => _UpdateDialog(
          currentVersion: info.version,
          latestVersion: tag,
          downloadUrl: apkAsset['browser_download_url'] as String,
        ),
      );
    } catch (e) {
      if (mounted) _snack('Fehler: $e');
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  static bool _isNewer(String latest, String current) {
    int part(String v, int i) {
      final p = v.split('.');
      return i < p.length ? (int.tryParse(p[i]) ?? 0) : 0;
    }
    for (int i = 0; i < 3; i++) {
      final l = part(latest, i), c = part(current, i);
      if (l > c) return true;
      if (l < c) return false;
    }
    return false;
  }
}

class _UpdateDialog extends StatefulWidget {
  const _UpdateDialog({required this.currentVersion, required this.latestVersion, required this.downloadUrl});
  final String currentVersion;
  final String latestVersion;
  final String downloadUrl;

  @override
  State<_UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<_UpdateDialog> {
  bool _downloading = false;
  double? _progress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update verfügbar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Neue Version: v${widget.latestVersion}'),
          Text('Installiert:  v${widget.currentVersion}'),
          if (_downloading) ...[
            const SizedBox(height: 16),
            LinearProgressIndicator(value: _progress),
            const SizedBox(height: 6),
            Text(
              _progress != null ? '${(_progress! * 100).round()} %' : 'Verbinde...',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _downloading ? null : () => Navigator.pop(context),
          child: const Text('Später'),
        ),
        TextButton(
          onPressed: _downloading ? null : _download,
          child: const Text('Jetzt aktualisieren'),
        ),
      ],
    );
  }

  Future<void> _download() async {
    setState(() { _downloading = true; _progress = null; });
    try {
      final dir = await getTemporaryDirectory();
      final apkFile = File('${dir.path}/traum_update.apk');

      final client = http.Client();
      try {
        final req = http.Request('GET', Uri.parse(widget.downloadUrl));
        final resp = await client.send(req);
        final total = resp.contentLength;
        int received = 0;
        final sink = apkFile.openWrite();
        await for (final chunk in resp.stream) {
          sink.add(chunk);
          received += chunk.length;
          if (total != null && mounted) setState(() => _progress = received / total);
        }
        await sink.flush();
        await sink.close();
      } finally {
        client.close();
      }

      if (mounted) {
        Navigator.pop(context);
        await OpenFile.open(apkFile.path);
      }
    } catch (e) {
      if (mounted) {
        setState(() { _downloading = false; _progress = null; });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Download fehlgeschlagen: $e')));
      }
    }
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
