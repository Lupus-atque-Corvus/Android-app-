import 'package:flutter/material.dart';
import 'colors.dart';
import 'radius.dart';
import 'typography.dart';

class TraumTheme {
  TraumTheme._();

  static ThemeData get dark => _build(dark: true);
  static ThemeData get light => _build(dark: false);

  static ThemeData _build({required bool dark}) {
    final background =
        dark ? TraumColors.background : TraumColors.backgroundLight;
    final surface = dark ? TraumColors.surface : TraumColors.surfaceLight;
    final onBackground =
        dark ? TraumColors.onBackground : TraumColors.onBackgroundLight;
    final textTheme = TraumTypography.buildTextTheme(dark: dark);
    final inputFill =
        dark ? TraumColors.surfaceVariant : const Color(0xFFEEEEF5);

    return ThemeData(
      useMaterial3: true,
      brightness: dark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme(
        brightness: dark ? Brightness.dark : Brightness.light,
        primary: TraumColors.coralOrange,
        onPrimary: Colors.white,
        primaryContainer: TraumColors.coralDim,
        onPrimaryContainer: TraumColors.coralOrange,
        secondary: TraumColors.cyanBlue,
        onSecondary: Colors.white,
        secondaryContainer: TraumColors.cyanDim,
        onSecondaryContainer: TraumColors.cyanBlue,
        surface: surface,
        onSurface: onBackground,
        error: TraumColors.error,
        onError: Colors.white,
        outline: TraumColors.inputBorder,
        shadow: Colors.transparent,
        scrim: Colors.black54,
        inverseSurface:
            dark ? TraumColors.onBackground : TraumColors.background,
        onInverseSurface:
            dark ? TraumColors.background : TraumColors.onBackground,
        inversePrimary: TraumColors.peachOrange,
        surfaceTint: Colors.transparent,
      ),
      scaffoldBackgroundColor: background,
      cardColor: surface,
      textTheme: textTheme,

      // ── AppBar ─────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: textTheme.headlineMedium,
        iconTheme: IconThemeData(color: onBackground),
      ),

      // ── Cards ──────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: TraumRadius.card,
          side: const BorderSide(color: TraumColors.cardBorder),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Inputs ─────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        border: OutlineInputBorder(
          borderRadius: TraumRadius.inputField,
          borderSide: const BorderSide(color: TraumColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: TraumRadius.inputField,
          borderSide: const BorderSide(color: TraumColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: TraumRadius.inputField,
          borderSide:
              const BorderSide(color: TraumColors.coralOrange, width: 1.5),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: TraumColors.onBackgroundMuted,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),

      // ── Buttons ────────────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TraumColors.coralOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: TraumRadius.button),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: TraumColors.cyanBlue,
          shape: RoundedRectangleBorder(borderRadius: TraumRadius.button),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: TraumColors.coralOrange,
          side: const BorderSide(color: TraumColors.coralOrange),
          shape: RoundedRectangleBorder(borderRadius: TraumRadius.button),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ── Icons ──────────────────────────────────────────────────────────────
      iconTheme: IconThemeData(
          color: onBackground.withValues(alpha: 0.70), size: 24),

      // ── Switch / Checkbox ──────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TraumColors.coralOrange;
          }
          return TraumColors.onBackgroundSubtle;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TraumColors.coralDim;
          }
          return dark ? TraumColors.surfaceVariant : const Color(0xFFCCCCDD);
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TraumColors.coralOrange;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: TraumColors.onBackgroundMuted),
      ),

      // ── Divider ────────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: TraumColors.divider,
        thickness: 1,
        space: 0,
      ),

      // ── SnackBar ───────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: TraumColors.surface,
        contentTextStyle:
            textTheme.bodyMedium?.copyWith(color: onBackground),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: TraumRadius.card,
          side: const BorderSide(color: TraumColors.coralOrange, width: 1),
        ),
        elevation: 0,
      ),

      // ── Dialog ─────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: TraumColors.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: TraumRadius.cardLarge,
          side: const BorderSide(color: TraumColors.cardBorder),
        ),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),

      // ── Bottom Sheet ────────────────────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: TraumColors.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: TraumRadius.bottomNav,
          side: BorderSide(color: TraumColors.cardBorder),
        ),
      ),

      // ── List tiles ─────────────────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        iconColor: onBackground.withValues(alpha: 0.70),
        textColor: onBackground,
        tileColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: TraumRadius.small),
      ),

      // ── Bottom navigation ──────────────────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: TraumColors.bottomNav,
        selectedItemColor: TraumColors.coralOrange,
        unselectedItemColor: TraumColors.onBackgroundSubtle,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // ── Expansion tile ─────────────────────────────────────────────────────
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: TraumColors.onBackgroundMuted,
        collapsedIconColor: TraumColors.onBackgroundMuted,
        textColor: onBackground,
        collapsedTextColor: onBackground,
      ),

      // ── Progress indicators ─────────────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: TraumColors.coralOrange,
        linearTrackColor: TraumColors.cardBorder, // white 8%
      ),

      // ── Tab bar ─────────────────────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelColor: onBackground,
        unselectedLabelColor: TraumColors.onBackgroundMuted,
        indicator: BoxDecoration(
          color: TraumColors.coralOrange,
          borderRadius: TraumRadius.chip,
        ),
        dividerColor: Colors.transparent,
      ),
    );
  }
}
