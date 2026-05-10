import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class TraumTypography {
  TraumTypography._();

  static TextTheme buildTextTheme({required bool dark}) {
    final color = dark ? TraumColors.onBackground : TraumColors.onBackgroundLight;
    final mutedColor =
        dark ? TraumColors.onBackgroundMuted : const Color(0xFF555577);

    return TextTheme(
      // Display — giant clock
      displayLarge: GoogleFonts.dmSans(
        fontSize: 52,
        fontWeight: FontWeight.bold,
        color: color,
        height: 1.0,
      ),
      // Section metric values
      displayMedium: GoogleFonts.dmSans(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      displaySmall: GoogleFonts.dmSans(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      // Screen headings
      headlineLarge: GoogleFonts.dmSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      headlineMedium: GoogleFonts.dmSans(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      headlineSmall: GoogleFonts.dmSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      // Section headers
      titleLarge: GoogleFonts.dmSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleMedium: GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleSmall: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      // Body text
      bodyLarge: GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: color,
      ),
      bodyMedium: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: color,
      ),
      bodySmall: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: mutedColor,
      ),
      // Labels
      labelLarge: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
      ),
      labelMedium: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: mutedColor,
      ),
      labelSmall: GoogleFonts.dmSans(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: mutedColor,
      ),
    );
  }
}
