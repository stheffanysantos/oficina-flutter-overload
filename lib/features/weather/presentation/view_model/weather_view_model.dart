import 'package:flutter/foundation.dart';
import 'package:rotina/core/failure.dart';
import 'package:rotina/features/weather/domain/entities/weather.dart';
import 'package:rotina/features/weather/domain/usecases/get_current_weather.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherViewModel(this._getCurrentWeather);

  final GetCurrentWeather _getCurrentWeather;

  Weather? weather;
  bool loading = false;
  String? error;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      weather = await _getCurrentWeather();
    } on Failure catch (e) {
      error = e.message;
    } catch (_) {
      error = 'Não foi possível carregar o clima';
    }
    loading = false;
    notifyListeners();
  }
}
