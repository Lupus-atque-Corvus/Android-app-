import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/preferences/preferences_repository.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});

// Increment to force preferencesRepositoryProvider to rebuild and notify watchers
final prefsVersionProvider = StateProvider<int>((ref) => 0);

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
  ref.watch(prefsVersionProvider); // rebuild when any pref changes
  return PreferencesRepository(ref.watch(sharedPreferencesProvider));
});

// ── Theme ────────────────────────────────────────────────────────────────────
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final prefs = ref.watch(preferencesRepositoryProvider);
    return switch (prefs.appTheme) {
      'light' => ThemeMode.light,
      'system' => ThemeMode.system,
      _ => ThemeMode.dark,
    };
  }

  Future<void> setTheme(String mode) async {
    await ref.read(preferencesRepositoryProvider).setAppTheme(mode);
    state = switch (mode) {
      'light' => ThemeMode.light,
      'system' => ThemeMode.system,
      _ => ThemeMode.dark,
    };
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

// ── Locale ───────────────────────────────────────────────────────────────────
class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() {
    final code = ref.watch(preferencesRepositoryProvider).appLocale;
    return code != null ? Locale(code) : null;
  }

  Future<void> setLocale(String code) async {
    await ref.read(preferencesRepositoryProvider).setAppLocale(code);
    state = Locale(code);
  }

  Future<void> clearLocale() async {
    await ref.read(preferencesRepositoryProvider).clearAppLocale();
    state = null;
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(LocaleNotifier.new);

// ── Simple read-only providers ────────────────────────────────────────────────
final userNameProvider = Provider<String>(
  (ref) => ref.watch(preferencesRepositoryProvider).userName,
);

final userBiologicalSexProvider = Provider<String>(
  (ref) => ref.watch(preferencesRepositoryProvider).userBiologicalSex,
);

final onboardingCompleteProvider = Provider<bool>(
  (ref) => ref.watch(preferencesRepositoryProvider).onboardingComplete,
);

final isPeriodTrackingEnabledProvider = Provider<bool>(
  (ref) => ref.watch(preferencesRepositoryProvider).isPeriodTrackingEnabled,
);

// ── Nav slots (configurable, Home excluded) ───────────────────────────────────

class NavSlotsNotifier extends StateNotifier<List<String>> {
  NavSlotsNotifier(this._prefs, List<String> initial) : super(initial);

  final PreferencesRepository _prefs;

  static const _defaultSlots = ['training', 'health', 'nutrition', 'budget'];
  static const _fixedKeys = {'home', 'more'};

  Future<void> addSlot(String module) async {
    if (state.length >= 4 || state.contains(module) || _fixedKeys.contains(module)) return;
    final updated = [...state, module];
    state = updated;
    await _prefs.setNavSlots(jsonEncode(updated));
  }

  Future<void> removeSlot(String module) async {
    if (state.length <= 1 || _fixedKeys.contains(module)) return;
    final updated = state.where((s) => s != module).toList();
    state = updated;
    await _prefs.setNavSlots(jsonEncode(updated));
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final updated = List<String>.from(state);
    if (newIndex > oldIndex) newIndex--;
    final item = updated.removeAt(oldIndex);
    updated.insert(newIndex, item);
    state = updated;
    await _prefs.setNavSlots(jsonEncode(updated));
  }

  static List<String> _parse(String raw) {
    try {
      final decoded = (jsonDecode(raw) as List<dynamic>).cast<String>();
      // Remove fixed keys that used to be stored in slots
      final filtered = decoded.where((s) => !_fixedKeys.contains(s)).toList();
      if (filtered.isEmpty) return List.from(_defaultSlots);
      return filtered.take(4).toList();
    } catch (_) {
      return List.from(_defaultSlots);
    }
  }
}

final navSlotsProvider =
    StateNotifierProvider<NavSlotsNotifier, List<String>>((ref) {
  final prefs = ref.watch(preferencesRepositoryProvider);
  final slots = NavSlotsNotifier._parse(prefs.navSlots);
  return NavSlotsNotifier(prefs, slots);
});

final stepsGoalProvider = Provider<int>(
  (ref) => ref.watch(preferencesRepositoryProvider).stepsGoal,
);

final kcalGoalProvider = Provider<int>(
  (ref) => ref.watch(preferencesRepositoryProvider).kcalGoal,
);

final waterGoalMlProvider = Provider<int>(
  (ref) => ref.watch(preferencesRepositoryProvider).waterGoalMl,
);

final proteinGoalGProvider = Provider<int>(
  (ref) => ref.watch(preferencesRepositoryProvider).proteinGoalG,
);

final currencySymbolProvider = Provider<String>(
  (ref) => ref.watch(preferencesRepositoryProvider).currencySymbol,
);

final unitSystemProvider = Provider<String>(
  (ref) => ref.watch(preferencesRepositoryProvider).unitSystem,
);
