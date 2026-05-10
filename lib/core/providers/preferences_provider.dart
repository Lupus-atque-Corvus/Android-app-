import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/preferences/preferences_repository.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override in ProviderScope');
});

final preferencesRepositoryProvider = Provider<PreferencesRepository>((ref) {
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

final navSlotsProvider = Provider<List<String>>((ref) {
  final raw = ref.watch(preferencesRepositoryProvider).navSlots;
  final decoded = json.decode(raw) as List<dynamic>;
  return decoded.cast<String>();
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
