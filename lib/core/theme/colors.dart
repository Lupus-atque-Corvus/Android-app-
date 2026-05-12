import 'package:flutter/material.dart';

class TraumColors {
  TraumColors._();

  // ── Backgrounds ───────────────────────────────────────────────────────────
  static const Color background = Color(0xFF07090F);       // deepest app bg
  static const Color surface = Color(0xFF0F1115);          // cards & nav bar
  static const Color surfaceVariant = Color(0xFF141720);   // elevated surface, inputs
  static const Color bottomNav = Color(0xFF0F1115);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color onBackground = Color(0xFFFAFAFA);
  static const Color onBackgroundMuted = Color(0xB3FFFFFF);    // white 70%
  static const Color onBackgroundSubtle = Color(0x80FFFFFF);   // white 50%

  // ── Accent Warm ───────────────────────────────────────────────────────────
  static const Color coralOrange = Color(0xFFFF6B3D);
  static const Color peachOrange = Color(0xFFFFAA55);
  static const Color coralDim = Color(0x33FF6B3D);

  // ── Accent Cool ───────────────────────────────────────────────────────────
  static const Color cyanBlue = Color(0xFF00D4D4);
  static const Color turquoiseBlue = Color(0xFF0099BB);
  static const Color cyanDim = Color(0x3300D4D4);

  // ── Status ────────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF2DD4BF);
  static const Color warning = Color(0xFFFFB347);
  static const Color error = Color(0xFFFF4466);
  static const Color overbudget = Color(0xFFFF4466);

  // ── Period tracking ───────────────────────────────────────────────────────
  static const Color periodRose = Color(0xFFFF8FAB);
  static const Color ovulationCyan = Color(0xFF00C9C8);
  static const Color fertileCyan = Color(0xFF0093AB);

  // ── Light Theme ───────────────────────────────────────────────────────────
  static const Color backgroundLight = Color(0xFFF5F5FA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF1A1A2E);

  // ── Shared borders ────────────────────────────────────────────────────────
  /// 1px border for cards and containers — white 8% opacity
  static const Color cardBorder = Color(0x14FFFFFF);
  /// 1px border for inputs — white 10% opacity
  static const Color inputBorder = Color(0x1AFFFFFF);
  /// Divider line — white 6% opacity
  static const Color divider = Color(0x0FFFFFFF);

  // ── Glow shadows ─────────────────────────────────────────────────────────
  static const BoxShadow coralGlow = BoxShadow(
    color: Color(0x29FF6B3D),
    blurRadius: 20,
    spreadRadius: 0,
  );
  static const BoxShadow cyanGlow = BoxShadow(
    color: Color(0x2900D4D4),
    blurRadius: 20,
    spreadRadius: 0,
  );

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient gradientWarm = LinearGradient(
    colors: [coralOrange, peachOrange],
  );
  static const LinearGradient gradientCool = LinearGradient(
    colors: [cyanBlue, turquoiseBlue],
  );
  static const LinearGradient gradientAccent = LinearGradient(
    colors: [coralOrange, cyanBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
