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
        outline: TraumColors.onBackgroundSubtle,
        shadow: Colors.black26,
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
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: textTheme.headlineMedium,
        iconTheme: IconThemeData(color: onBackground),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: TraumColors.bottomNav,
        selectedItemColor: TraumColors.coralOrange,
        unselectedItemColor: TraumColors.onBackgroundSubtle,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: TraumRadius.card),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? TraumColors.surfaceVariant : const Color(0xFFEEEEF5),
        border: OutlineInputBorder(
          borderRadius: TraumRadius.inputField,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: TraumRadius.inputField,
          borderSide: BorderSide.none,
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TraumColors.coralOrange,
          foregroundColor: Colors.white,
          elevation: 0,
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
      iconTheme: IconThemeData(color: onBackground, size: 24),
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
        side: const BorderSide(color: TraumColors.onBackgroundMuted),
      ),
      dividerTheme: const DividerThemeData(
        color: TraumColors.surfaceVariant,
        thickness: 1,
        space: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surface,
        contentTextStyle:
            textTheme.bodyMedium?.copyWith(color: onBackground),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: TraumRadius.card),
        elevation: 4,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(borderRadius: TraumRadius.cardLarge),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        shape: const RoundedRectangleBorder(
          borderRadius: TraumRadius.bottomNav,
        ),
        elevation: 0,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: onBackground,
        textColor: onBackground,
        tileColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: TraumRadius.small),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: TraumColors.onBackgroundMuted,
        collapsedIconColor: TraumColors.onBackgroundMuted,
        textColor: onBackground,
        collapsedTextColor: onBackground,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: TraumColors.coralOrange,
        linearTrackColor: TraumColors.surfaceVariant,
      ),
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
