// Evidence-based cycle calculation utilities.
//
// References used throughout this file:
// [1] Fehring RJ et al. (2006). Accuracy of the Peak Day of Cervical Mucus as a Biological Marker of Fertility.
//     JOGNN 35(3):444–449. Luteal phase ≈ 14 days constant; follicular phase varies.
//     Therefore: ovulation ≈ cycleStart + (cycleLength − 14).
// [2] Wilcox AJ et al. (1995). Timing of Sexual Intercourse in Relation to Ovulation.
//     N Engl J Med 333:1517–1521. Fertile window: 5 days before ovulation through ovulation day.
//     Sperm survives ≤5 days; ovum viable 12–24 h.
// [3] Wilcox AJ et al. (1995). Per-day pregnancy probabilities within the fertile window.
// [4] ACOG Practice Bulletin. Menstrual cycle: normal 21–35 days; normal period 2–7 days.
// [5] ACOG. Irregular cycles defined as max−min variation ≥ 7 days across consecutive cycles.
// [6] Bäckström T et al. (2003). The role of hormones and hormonal treatments in premenstrual syndrome.
//     CNS Drugs 17(5):325–342. PMS/PMDD symptoms occur during the luteal phase (≤14 days before period).

class CycleCalculation {
  const CycleCalculation({
    required this.ovulationDate,
    required this.fertileStart,
    required this.fertileEnd,
    required this.nextPeriodPredicted,
    required this.pregnancyProbability,
  });

  final DateTime ovulationDate;
  final DateTime fertileStart;
  final DateTime fertileEnd;
  final DateTime nextPeriodPredicted;

  /// Probability of conception today (0.0–1.0). Based on Wilcox et al. 1995 [3].
  final double pregnancyProbability;
}

/// Aggregate statistics computed from a list of recent cycles.
class CycleAnalysis {
  const CycleAnalysis({
    required this.cycleLengths,
    required this.periodLengths,
    required this.avgCycleLength,
    required this.avgPeriodLength,
    required this.minCycleLength,
    required this.maxCycleLength,
    required this.variation,
    required this.isIrregular,
    required this.hasEnoughData,
    required this.cycleTrend,
    required this.hasAbnormalCycle,
    required this.hasAbnormalPeriod,
  });

  /// Up to last 12 cycle lengths, oldest first (for charts).
  final List<int> cycleLengths;

  /// Period durations in days (where end date recorded), oldest first.
  final List<int> periodLengths;

  /// Average cycle length from the last 3 cycles for responsive prognosis.
  final int avgCycleLength;

  /// Average period duration.
  final int avgPeriodLength;

  final int minCycleLength;
  final int maxCycleLength;

  /// Variation = max − min across all included cycles.
  final int variation;

  /// True if variation ≥ 7 days — ACOG definition of irregular cycle. [5]
  final bool isIrregular;

  /// True when ≥ 3 cycles are available; below this, prognosis should be marked "estimated".
  final bool hasEnoughData;

  /// Avg(last 3 cycles) − avg(cycles 4–6). Positive = getting longer, negative = shorter.
  /// Zero when fewer than 6 cycles are available.
  final double cycleTrend;

  /// Any cycle length outside the normal 21–35 day range. [4]
  final bool hasAbnormalCycle;

  /// Any period length outside the normal 2–7 day range. [4]
  final bool hasAbnormalPeriod;
}

class CycleCalculator {
  // ── Single-cycle calculation ──────────────────────────────────────────────────

  /// Calculate ovulation, fertile window, and next period from one period start date.
  ///
  /// Uses the constant-luteal-phase model [1]:
  ///   ovulationDate = lastPeriodStart + (avgCycleLength − 14)
  static CycleCalculation calculate({
    required DateTime lastPeriodStart,
    required int avgCycleLength,
    required int avgPeriodLength,
    DateTime? referenceDate,
  }) {
    final ref = referenceDate ?? DateTime.now();

    // [1] Ovulation = cycle start + (cycle length − 14)
    final ovulationDate = lastPeriodStart.add(Duration(days: avgCycleLength - 14));

    // [2] Fertile window: 5 days before ovulation through 1 day after
    final fertileStart = ovulationDate.subtract(const Duration(days: 5));
    final fertileEnd = ovulationDate.add(const Duration(days: 1));

    final nextPeriodPredicted = lastPeriodStart.add(Duration(days: avgCycleLength));

    return CycleCalculation(
      ovulationDate: ovulationDate,
      fertileStart: fertileStart,
      fertileEnd: fertileEnd,
      nextPeriodPredicted: nextPeriodPredicted,
      pregnancyProbability: _pregnancyProbability(ref, ovulationDate, fertileStart, fertileEnd),
    );
  }

  /// Per-day pregnancy probability based on Wilcox et al. 1995 [3].
  /// Values: day −5=15 %, −4=17 %, −3=20 %, −2=22 %, −1=25 %, 0=28 %, +1=5 %, outside=0 %.
  static double _pregnancyProbability(
    DateTime ref,
    DateTime ovulation,
    DateTime fertileStart,
    DateTime fertileEnd,
  ) {
    final refDay = _dateOnly(ref);
    if (refDay.isBefore(_dateOnly(fertileStart)) ||
        refDay.isAfter(_dateOnly(fertileEnd))) {
      return 0.0;
    }

    final d = refDay.difference(_dateOnly(ovulation)).inDays;
    return switch (d) {
      -5 => 0.15,
      -4 => 0.17,
      -3 => 0.20,
      -2 => 0.22,
      -1 => 0.25,
       0 => 0.28,
       1 => 0.05,
       _ => 0.0,
    };
  }

  // ── Aggregate analysis ────────────────────────────────────────────────────────

  /// Compute aggregate statistics from raw cycle and period lengths.
  ///
  /// [cycleLengths] — list of cycle lengths in days, newest first.
  /// [periodLengths] — period durations in days (entries with end date), newest first.
  static CycleAnalysis analyze({
    required List<int> cycleLengths,
    required List<int> periodLengths,
  }) {
    // Limit to last 12 cycles for charts
    final cycles = (cycleLengths.length > 12
            ? cycleLengths.sublist(0, 12)
            : List<int>.from(cycleLengths))
        .where((l) => l >= 14 && l <= 60) // sanity filter
        .toList();

    final periods = (periodLengths.length > 12
            ? periodLengths.sublist(0, 12)
            : List<int>.from(periodLengths))
        .where((l) => l >= 1 && l <= 14)
        .toList();

    // Average from last 3 cycles — more responsive to recent changes
    final recent = cycles.length > 3 ? cycles.sublist(0, 3) : cycles;
    final avgCycle = recent.isNotEmpty
        ? (recent.reduce((a, b) => a + b) / recent.length).round()
        : 28;
    final avgPeriod = periods.isNotEmpty
        ? (periods.reduce((a, b) => a + b) / periods.length).round()
        : 5;

    final minCycle =
        cycles.isNotEmpty ? cycles.reduce((a, b) => a < b ? a : b) : avgCycle;
    final maxCycle =
        cycles.isNotEmpty ? cycles.reduce((a, b) => a > b ? a : b) : avgCycle;
    final variation = maxCycle - minCycle;

    // [5] Irregular if variation ≥ 7 days
    final isIrregular = variation >= 7;

    // Trend: avg(last 3) − avg(cycles 4–6)
    double trend = 0.0;
    if (cycles.length >= 6) {
      final r3 = cycles.sublist(0, 3);
      final o3 = cycles.sublist(3, 6);
      trend = r3.reduce((a, b) => a + b) / 3 -
              o3.reduce((a, b) => a + b) / 3;
    }

    // [4] Abnormal range checks per ACOG
    final hasAbnormalCycle = cycles.any((l) => l < 21 || l > 35);
    final hasAbnormalPeriod = periods.any((l) => l < 2 || l > 7);

    return CycleAnalysis(
      cycleLengths: cycles.reversed.toList(), // oldest first for X-axis
      periodLengths: periods.reversed.toList(),
      avgCycleLength: avgCycle,
      avgPeriodLength: avgPeriod,
      minCycleLength: minCycle,
      maxCycleLength: maxCycle,
      variation: variation,
      isIrregular: isIrregular,
      hasEnoughData: cycles.length >= 3,
      cycleTrend: trend,
      hasAbnormalCycle: hasAbnormalCycle,
      hasAbnormalPeriod: hasAbnormalPeriod,
    );
  }

  // ── Helper methods ────────────────────────────────────────────────────────────

  static int daysUntilNextPeriod(DateTime nextPeriod) {
    final start = _today();
    final target = _dateOnly(nextPeriod);
    return target.difference(start).inDays;
  }

  static bool isInPeriod(DateTime date, DateTime periodStart, int periodLength) {
    final end = periodStart.add(Duration(days: periodLength));
    return !date.isBefore(periodStart) && date.isBefore(end);
  }

  /// True when today falls within 14 days before the predicted next period (luteal phase).
  /// PMS/PMDD symptoms typically occur in this window. [6]
  static bool isInLutealPhase(DateTime nextPeriodPredicted) {
    final d = _dateOnly(nextPeriodPredicted).difference(_today()).inDays;
    return d >= 0 && d <= 14;
  }

  /// True if cycle length is outside the normal 21–35 day range. [4]
  static bool isAbnormalCycleLength(int length) => length < 21 || length > 35;

  /// True if period length is outside the normal 2–7 day range. [4]
  static bool isAbnormalPeriodLength(int length) => length < 2 || length > 7;

  static DateTime _today() {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  static DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}
