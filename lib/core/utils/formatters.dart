String formatCurrency(double amount, {String symbol = '€', int decimals = 2}) {
  final abs = amount.abs();
  final sign = amount < 0 ? '-' : '';
  return '$sign${abs.toStringAsFixed(decimals)} $symbol';
}

String formatDuration(int seconds) {
  if (seconds < 60) return '${seconds}s';
  if (seconds < 3600) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return s == 0 ? '${m}m' : '${m}m ${s}s';
  }
  final h = seconds ~/ 3600;
  final m = (seconds % 3600) ~/ 60;
  return m == 0 ? '${h}h' : '${h}h ${m}m';
}

String formatElapsed(Duration d) {
  final days = d.inDays;
  final hours = d.inHours % 24;
  final minutes = d.inMinutes % 60;
  if (days > 0) return '${days}T ${hours}h ${minutes}m';
  if (hours > 0) return '${hours}h ${minutes}m';
  return '${minutes}m';
}

String formatWeight(double kg, {bool imperial = false}) {
  if (imperial) {
    return '${(kg * 2.20462).toStringAsFixed(1)} lbs';
  }
  return '${kg.toStringAsFixed(1)} kg';
}

String formatDistance(double km, {bool imperial = false}) {
  if (imperial) {
    return '${(km * 0.621371).toStringAsFixed(2)} mi';
  }
  return '${km.toStringAsFixed(2)} km';
}

String formatCalories(double kcal) => '${kcal.round()} kcal';

String formatMl(int ml) {
  if (ml >= 1000) return '${(ml / 1000).toStringAsFixed(1)} L';
  return '$ml ml';
}
