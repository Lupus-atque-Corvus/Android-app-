import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'preferences_provider.dart';

class WeatherData {
  const WeatherData({
    required this.temperature,
    required this.weatherCode,
    required this.windspeed,
  });

  final double temperature;
  final int weatherCode;
  final double windspeed;
}

final weatherProvider = FutureProvider.autoDispose<WeatherData?>((ref) async {
  final prefs = ref.watch(preferencesRepositoryProvider);
  final lat = prefs.weatherLat;
  final lon = prefs.weatherLon;
  if (lat == null || lon == null) return null;

  final uri = Uri.parse(
    'https://api.open-meteo.com/v1/forecast'
    '?latitude=$lat&longitude=$lon'
    '&current=temperature_2m,weathercode,windspeed_10m'
    '&timezone=auto',
  );

  final response = await http.get(uri).timeout(const Duration(seconds: 10));
  if (response.statusCode != 200) return null;

  final body = jsonDecode(response.body) as Map<String, dynamic>;
  final current = body['current'] as Map<String, dynamic>;

  return WeatherData(
    temperature: (current['temperature_2m'] as num).toDouble(),
    weatherCode: (current['weathercode'] as num).toInt(),
    windspeed: (current['windspeed_10m'] as num).toDouble(),
  );
});
