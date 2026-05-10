import 'package:flutter_test/flutter_test.dart';
import 'package:traum/features/period_tracking/cycle_calculator.dart';

void main() {
  group('CycleCalculator', () {
    final lastPeriod = DateTime(2024, 1, 1);

    test('calculates ovulation on day 14 before expected period', () {
      final result = CycleCalculator.calculate(
        lastPeriodStart: lastPeriod,
        avgCycleLength: 28,
        avgPeriodLength: 5,
      );
      // Ovulation = lastPeriod + (28 - 14) = Jan 15
      expect(result.ovulationDate, DateTime(2024, 1, 15));
    });

    test('calculates fertile window 5 days before ovulation', () {
      final result = CycleCalculator.calculate(
        lastPeriodStart: lastPeriod,
        avgCycleLength: 28,
        avgPeriodLength: 5,
      );
      expect(result.fertileStart, DateTime(2024, 1, 10));
      expect(result.fertileEnd, DateTime(2024, 1, 16));
    });

    test('predicts next period after one full cycle', () {
      final result = CycleCalculator.calculate(
        lastPeriodStart: lastPeriod,
        avgCycleLength: 28,
        avgPeriodLength: 5,
      );
      expect(result.nextPeriodPredicted, DateTime(2024, 1, 29));
    });

    test('pregnancy probability is 0 outside fertile window', () {
      final result = CycleCalculator.calculate(
        lastPeriodStart: lastPeriod,
        avgCycleLength: 28,
        avgPeriodLength: 5,
        referenceDate: DateTime(2024, 1, 1),
      );
      expect(result.pregnancyProbability, 0.0);
    });

    test('pregnancy probability > 0 during fertile window', () {
      final result = CycleCalculator.calculate(
        lastPeriodStart: lastPeriod,
        avgCycleLength: 28,
        avgPeriodLength: 5,
        referenceDate: DateTime(2024, 1, 15), // ovulation day
      );
      expect(result.pregnancyProbability, greaterThan(0.0));
    });

    test('daysUntilNextPeriod calculates correctly', () {
      final future = DateTime.now().add(const Duration(days: 7));
      expect(CycleCalculator.daysUntilNextPeriod(future), 7);
    });

    test('isInPeriod returns true during period', () {
      final periodStart = DateTime(2024, 1, 1);
      expect(CycleCalculator.isInPeriod(DateTime(2024, 1, 3), periodStart, 5), true);
    });

    test('isInPeriod returns false after period ends', () {
      final periodStart = DateTime(2024, 1, 1);
      expect(CycleCalculator.isInPeriod(DateTime(2024, 1, 6), periodStart, 5), false);
    });
  });
}
