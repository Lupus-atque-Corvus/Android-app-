import 'package:flutter_test/flutter_test.dart';
import 'package:traum/core/utils/formatters.dart';

void main() {
  group('formatCurrency', () {
    test('formats positive amount', () {
      expect(formatCurrency(12.5), '12.50 €');
    });

    test('formats negative amount', () {
      expect(formatCurrency(-5.0), '-5.00 €');
    });

    test('respects custom symbol', () {
      expect(formatCurrency(100, symbol: '\$'), '100.00 \$');
    });
  });

  group('formatDuration', () {
    test('formats seconds only', () {
      expect(formatDuration(45), '45s');
    });

    test('formats minutes', () {
      expect(formatDuration(90), '1m 30s');
    });

    test('formats exact minutes', () {
      expect(formatDuration(120), '2m');
    });

    test('formats hours', () {
      expect(formatDuration(3600), '1h');
    });

    test('formats hours and minutes', () {
      expect(formatDuration(3720), '1h 2m');
    });
  });

  group('formatMl', () {
    test('shows ml for < 1000', () {
      expect(formatMl(500), '500 ml');
    });

    test('shows litres for >= 1000', () {
      expect(formatMl(1500), '1.5 L');
    });
  });

  group('formatWeight', () {
    test('formats kg', () {
      expect(formatWeight(75.5), '75.5 kg');
    });

    test('converts to lbs', () {
      expect(formatWeight(100, imperial: true), '220.5 lbs');
    });
  });
}
