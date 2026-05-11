import 'package:flutter/material.dart';

const _motivationQuotes = [
  'Mach heute etwas Großartiges',
  'Jeder Tag ist ein neuer Anfang',
  'Du schaffst das',
  'Bleib fokussiert',
  'Dein bestes Leben beginnt jetzt',
  'Kleine Schritte führen zu großen Zielen',
  'Glaube an dich selbst',
  'Heute ist dein Tag',
  'Wachse über dich hinaus',
  'Mach den ersten Schritt',
  'Stärke wächst durch Ausdauer',
  'Du bist stärker als du denkst',
  'Energie folgt der Aufmerksamkeit',
  'Sei die beste Version von dir',
  'Fortschritt schlägt Perfektion',
  'Jeder Moment zählt',
  'Halte niemals auf zu träumen',
  'Disziplin ist die Brücke zu deinen Zielen',
  'Investiere in dich selbst',
  'Das Beste kommt noch',
];

String dailyMotivation() {
  final now = DateTime.now();
  final dayOfYear = now.difference(DateTime(now.year)).inDays;
  return _motivationQuotes[dayOfYear % _motivationQuotes.length];
}

String greeting(String name) {
  final hour = TimeOfDay.now().hour;
  if (hour >= 5 && hour < 12) return 'Guten Morgen, $name';
  if (hour >= 12 && hour < 18) return 'Guten Tag, $name';
  if (hour >= 18 && hour < 22) return 'Guten Abend, $name';
  return 'Gute Nacht, $name';
}

String greetingKey() {
  final hour = TimeOfDay.now().hour;
  if (hour >= 5 && hour < 12) return 'greetingMorning';
  if (hour >= 12 && hour < 18) return 'greetingDay';
  if (hour >= 18 && hour < 22) return 'greetingEvening';
  return 'greetingNight';
}

String formatDate(DateTime d, {String locale = 'de'}) {
  final months = locale == 'de'
      ? ['Jan', 'Feb', 'Mär', 'Apr', 'Mai', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Dez']
      : ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${d.day}. ${months[d.month - 1]} ${d.year}';
}

String formatTime(DateTime d) {
  final h = d.hour.toString().padLeft(2, '0');
  final m = d.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

DateTime startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime startOfWeek(DateTime d) {
  final weekday = d.weekday;
  return startOfDay(d.subtract(Duration(days: weekday - 1)));
}

int daysBetween(DateTime a, DateTime b) =>
    startOfDay(b).difference(startOfDay(a)).inDays;

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

int age(DateTime birthday) {
  final now = DateTime.now();
  int years = now.year - birthday.year;
  if (now.month < birthday.month ||
      (now.month == birthday.month && now.day < birthday.day)) {
    years--;
  }
  return years;
}
