import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/providers/preferences_provider.dart';
import '../../../core/providers/weather_provider.dart';
import '../../../l10n/app_localizations.dart';

class HomeClockWeatherWidget extends ConsumerStatefulWidget {
  const HomeClockWeatherWidget({super.key});

  @override
  ConsumerState<HomeClockWeatherWidget> createState() =>
      _HomeClockWeatherWidgetState();
}

class _HomeClockWeatherWidgetState
    extends ConsumerState<HomeClockWeatherWidget> {
  late DateTime _now;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = l10n.localeName;
    final h = _now.hour.toString().padLeft(2, '0');
    final m = _now.minute.toString().padLeft(2, '0');
    final dateStr = DateFormat.yMMMMEEEEd(locale).format(_now);

    final weatherAsync = ref.watch(weatherProvider);
    final unitSystem = ref.watch(unitSystemProvider);
    final cityName = ref.watch(preferencesRepositoryProvider).weatherCityName;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1115),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Left: Clock + Date ────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$h:$m',
                  style: GoogleFonts.dmSans(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFAFAFA),
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateStr,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.60),
                  ),
                ),
              ],
            ),
          ),
          // ── Weather: only shown when data is available ─────────────────────
          weatherAsync.when(
            data: (data) {
              if (data == null) return const SizedBox.shrink();
              final icon = _weatherIcon(data.weatherCode);
              final description = _weatherDescription(l10n, data.weatherCode);
              final tempVal = unitSystem == 'imperial'
                  ? '${(data.temperature * 9 / 5 + 32).round()}°F'
                  : '${data.temperature.round()}°C';
              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 12),
                  // ── Middle: Weather icon ──────────────────────────────────
                  SizedBox(width: 52, height: 52, child: icon),
                  const SizedBox(width: 12),
                  // ── Right: Temp + Description + City ─────────────────────
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tempVal,
                        style: GoogleFonts.dmSans(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFFAFAFA),
                          height: 1.1,
                        ),
                      ),
                      Text(
                        description,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.70),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (cityName != null && cityName.isNotEmpty)
                        Text(
                          cityName,
                          style: GoogleFonts.dmSans(
                            fontSize: 11,
                            color: Colors.white.withValues(alpha: 0.50),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _weatherIcon(int code) {
    if (code == 0) {
      return const Icon(
        Icons.wb_sunny_rounded,
        color: Color(0xFFFFBF00),
        size: 52,
      );
    }
    if (code <= 2) {
      return Stack(
        children: [
          Positioned(
            top: 2,
            left: 2,
            child: Icon(
              Icons.wb_sunny_rounded,
              color: const Color(0xFFFF9800),
              size: 36,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              Icons.cloud_rounded,
              color: Colors.white70,
              size: 36,
            ),
          ),
        ],
      );
    }
    if (code == 3) {
      return const Icon(Icons.cloud_rounded, color: Colors.blueGrey, size: 52);
    }
    if (code <= 48) {
      return const Icon(Icons.blur_on, color: Colors.grey, size: 52);
    }
    if (code <= 55) {
      return const Icon(Icons.grain, color: Color(0xFF64B5F6), size: 52);
    }
    if (code <= 65) {
      return const Icon(
        Icons.water_drop_rounded,
        color: Color(0xFF42A5F5),
        size: 52,
      );
    }
    if (code <= 77) {
      return const Icon(Icons.ac_unit_rounded, color: Colors.lightBlue, size: 52);
    }
    if (code <= 82) {
      return const Icon(Icons.umbrella, color: Color(0xFF42A5F5), size: 52);
    }
    if (code >= 95) {
      return const Icon(Icons.bolt_rounded, color: Color(0xFFFFBF00), size: 52);
    }
    return const Icon(Icons.cloud_outlined, color: Colors.grey, size: 52);
  }

  String _weatherDescription(AppLocalizations l10n, int code) {
    if (code == 0) return l10n.weatherClear;
    if (code == 1) return l10n.weatherMostlyClear;
    if (code == 2) return l10n.weatherPartlyCloudy;
    if (code == 3) return l10n.weatherOvercast;
    if (code <= 48) return l10n.weatherFoggy;
    if (code <= 55) return l10n.weatherDrizzle;
    if (code <= 65) return l10n.weatherRain;
    if (code <= 75) return l10n.weatherSnowfall;
    if (code == 77) return l10n.weatherSnowGrains;
    if (code <= 82) return l10n.weatherRainShowers;
    if (code <= 86) return l10n.weatherSnowShowers;
    if (code == 95) return l10n.weatherThunderstorm;
    return l10n.weatherHeavyThunderstorm;
  }
}
