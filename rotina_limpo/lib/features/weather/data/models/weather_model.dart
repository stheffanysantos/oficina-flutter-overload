import 'package:rotina_limpo/features/weather/domain/entities/weather.dart';

class WeatherModel {
  const WeatherModel({required this.temperature, required this.code});

  /// Formato da resposta da Open-Meteo:
  /// {"current": {"temperature_2m": 22.4, "weather_code": 3}}
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    return WeatherModel(
      temperature: (current['temperature_2m'] as num).toDouble(),
      code: (current['weather_code'] as num).toInt(),
    );
  }

  final double temperature;
  final int code;

  Weather toEntity() =>
      Weather(temperature: temperature, description: _describe(code));

  static String _describe(int code) {
    if (code == 0) return 'Céu limpo';
    if (code <= 3) return 'Parcialmente nublado';
    if (code == 45 || code == 48) return 'Neblina';
    if (code >= 51 && code <= 67) return 'Chuva';
    if (code >= 71 && code <= 77) return 'Neve';
    if (code >= 80 && code <= 82) return 'Pancadas de chuva';
    if (code >= 95) return 'Tempestade';
    return 'Tempo instável';
  }
}
