import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rotina/core/failure.dart';
import 'package:rotina/features/weather/data/models/weather_model.dart';

class WeatherRemoteDataSource {
  WeatherRemoteDataSource(this._client);

  final http.Client _client;

  // São Paulo
  static const _latitude = '-23.55';
  static const _longitude = '-46.63';

  Future<WeatherModel> fetchCurrent() async {
    final response = await _client.get(
      Uri.https('api.open-meteo.com', '/v1/forecast', {
        'latitude': _latitude,
        'longitude': _longitude,
        'current': 'temperature_2m,weather_code',
      }),
    );
    if (response.statusCode != 200) {
      throw Failure('Erro ao buscar o clima (${response.statusCode})');
    }
    return WeatherModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
