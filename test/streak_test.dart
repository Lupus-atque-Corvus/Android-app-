import 'package:flutter_test/flutter_test.dart';
import 'package:traum/core/utils/streak.dart';

void main() {
  group('calculateStreak', () {
    test('returns 0 for empty list', () {
      expect(calculateStreak([]), 0);
    });

    test('returns 1 for single entry today', () {
      expect(calculateStreak([DateTime.now()]), 1);
    });

    test('returns 1 for single entry yesterday', () {
      expect(calculateStreak([DateTime.now().subtract(const Duration(days: 1))]), 1);
    });

    test('returns 0 when last entry is 2 days ago', () {
      expect(calculateStreak([DateTime.now().subtract(const Duration(days: 2))]), 0);
    });

    test('counts consecutive days', () {
      final now = DateTime.now();
      final dates = [
        now,
        now.subtract(const Duration(days: 1)),
        now.subtract(const Duration(days: 2)),
        now.subtract(const Duration(days: 3)),
      ];
      expect(calculateStreak(dates), 4);
    });

    test('stops at gap in streak', () {
      final now = DateTime.now();
      final dates = [
        now,
        now.subtract(const Duration(days: 1)),
        // gap on day 2
        now.subtract(const Duration(days: 3)),
        now.subtract(const Duration(days: 4)),
      ];
      expect(calculateStreak(dates), 2);
    });

    test('ignores duplicate dates', () {
      final now = DateTime.now();
      final dates = [now, now, now.subtract(const Duration(days: 1))];
      expect(calculateStreak(dates), 2);
    });
  });
}
