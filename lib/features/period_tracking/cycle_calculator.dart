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
  final double pregnancyProbability;
}

class CycleCalculator {
  static CycleCalculation calculate({
    required DateTime lastPeriodStart,
    required int avgCycleLength,
    required int avgPeriodLength,
    DateTime? referenceDate,
  }) {
    final ref = referenceDate ?? DateTime.now();

    final ovulationDate = lastPeriodStart.add(Duration(days: avgCycleLength - 14));
    final fertileStart = ovulationDate.subtract(const Duration(days: 5));
    final fertileEnd = ovulationDate.add(const Duration(days: 1));
    final nextPeriodPredicted = lastPeriodStart.add(Duration(days: avgCycleLength));

    final inFertileWindow = !ref.isBefore(fertileStart) && !ref.isAfter(fertileEnd);
    final daysFromOvulation = ref.difference(ovulationDate).inDays.abs();
    final prob = inFertileWindow ? (1.0 - daysFromOvulation / 6.0).clamp(0.0, 1.0) : 0.0;

    return CycleCalculation(
      ovulationDate: ovulationDate,
      fertileStart: fertileStart,
      fertileEnd: fertileEnd,
      nextPeriodPredicted: nextPeriodPredicted,
      pregnancyProbability: prob,
    );
  }

  static int daysUntilNextPeriod(DateTime nextPeriod) {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final target = DateTime(nextPeriod.year, nextPeriod.month, nextPeriod.day);
    return target.difference(start).inDays;
  }

  static bool isInPeriod(DateTime date, DateTime periodStart, int periodLength) {
    final end = periodStart.add(Duration(days: periodLength));
    return !date.isBefore(periodStart) && date.isBefore(end);
  }
}
