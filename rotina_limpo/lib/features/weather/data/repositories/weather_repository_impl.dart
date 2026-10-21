import 'package:rotina_limpo/core/failure.dart';
import 'package:rotina_limpo/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:rotina_limpo/features/weather/domain/entities/weather.dart';
import 'package:rotina_limpo/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this._remote);

  final WeatherRemoteDataSource _remote;

  @override
  Future<Weather> getCurrentWeather() async {
    try {
      final model = await _remote.fetchCurrent();
      return model.toEntity();
    } on Failure {
      rethrow;
    } catch (_) {
      throw const Failure('Não foi possível carregar o clima');
    }
  }
}
