import 'package:flutter_test/flutter_test.dart';
import 'package:rotina_limpo/features/weather/data/models/weather_model.dart';

void main() {
  test('converte o JSON da API em entidade com descrição em português', () {
    final model = WeatherModel.fromJson({
      'current': {'temperature_2m': 22.4, 'weather_code': 3},
    });

    final weather = model.toEntity();

    expect(weather.temperature, 22.4);
    expect(weather.description, 'Parcialmente nublado');
  });
}
