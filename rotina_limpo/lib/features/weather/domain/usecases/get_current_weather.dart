import 'package:rotina_limpo/features/weather/domain/entities/weather.dart';
import 'package:rotina_limpo/features/weather/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  GetCurrentWeather(this._repository);

  final WeatherRepository _repository;

  Future<Weather> call() => _repository.getCurrentWeather();
}
