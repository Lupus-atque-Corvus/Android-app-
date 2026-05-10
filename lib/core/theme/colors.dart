import 'package:flutter/material.dart';

class TraumColors {
  TraumColors._();

  // Backgrounds
  static const Color background = Color(0xFF0D0D1A);
  static const Color surface = Color(0xFF1A1A2E);
  static const Color surfaceVariant = Color(0xFF22223A);
  static const Color bottomNav = Color(0xFF12121F);

  // Text
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color onBackgroundMuted = Color(0xFF8888AA);
  static const Color onBackgroundSubtle = Color(0xFF555577);

  // Accent Warm
  static const Color coralOrange = Color(0xFFFF6B3D);
  static const Color peachOrange = Color(0xFFFFAA55);
  static const Color coralDim = Color(0x33FF6B3D);

  // Accent Cool
  static const Color cyanBlue = Color(0xFF00D4D4);
  static const Color turquoiseBlue = Color(0xFF0099BB);
  static const Color cyanDim = Color(0x3300D4D4);

  // Status
  static const Color success = Color(0xFF2DD4BF);
  static const Color warning = Color(0xFFFFB347);
  static const Color error = Color(0xFFFF4466);
  static const Color overbudget = Color(0xFFFF4466);

  // Period tracking extras
  static const Color periodRose = Color(0xFFFF8FAB);
  static const Color ovulationCyan = Color(0xFF00C9C8);
  static const Color fertileCyan = Color(0xFF0093AB);

  // Light Theme
  static const Color backgroundLight = Color(0xFFF5F5FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF1A1A2E);

  // Gradients
  static const LinearGradient gradientWarm = LinearGradient(
    colors: [coralOrange, peachOrange],
  );
  static const LinearGradient gradientCool = LinearGradient(
    colors: [cyanBlue, turquoiseBlue],
  );
  static const LinearGradient gradientAccent = LinearGradient(
    colors: [coralOrange, cyanBlue],
  );
  static const LinearGradient gradientBudgetLine = LinearGradient(
    colors: [peachOrange, coralOrange],
  );
  static const LinearGradient cycleGradient = LinearGradient(
    colors: [Color(0xFFFF7E5F), Color(0xFF00C9C8)],
  );
}
