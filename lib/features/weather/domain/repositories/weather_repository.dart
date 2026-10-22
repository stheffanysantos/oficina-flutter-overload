import 'package:rotina/features/weather/domain/entities/weather.dart';

abstract interface class WeatherRepository {
  Future<Weather> getCurrentWeather();
}
