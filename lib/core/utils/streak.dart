import 'date_utils.dart';

int calculateStreak(List<DateTime> logDates) {
  if (logDates.isEmpty) return 0;

  final sorted = logDates.map(startOfDay).toSet().toList()
    ..sort((a, b) => b.compareTo(a));

  final today = startOfDay(DateTime.now());
  final yesterday = today.subtract(const Duration(days: 1));

  if (!isSameDay(sorted.first, today) && !isSameDay(sorted.first, yesterday)) {
    return 0;
  }

  int streak = 1;
  for (int i = 0; i < sorted.length - 1; i++) {
    final diff = sorted[i].difference(sorted[i + 1]).inDays;
    if (diff == 1) {
      streak++;
    } else {
      break;
    }
  }
  return streak;
}
