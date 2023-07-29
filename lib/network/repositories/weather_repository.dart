import 'package:dartz/dartz.dart';

import '../../models/weather_data.dart';
import '../api_constants.dart';
import '../api_service.dart';
import '../failures.dart';

class WeatherRepository {
  WeatherRepository(this._apiService);

  final ApiService _apiService;

  Future<Either<Failure, ForecastData>> getForecastByCity(
    String city,
    int days,
  ) =>
      _getForecast('q=$city', days);

  Future<Either<Failure, ForecastData>> getForecastByLoc(
    double lat,
    double lng,
    int days,
  ) =>
      _getForecast('lat=$lat&lon=$lng', days);

  Future<Either<Failure, ForecastData>> _getForecast(
    String locationQuerry,
    int days,
  ) async {
    final url =
        '${WeatherApiConstants.weatherUrl}?$locationQuerry&appid=${WeatherApiConstants.weatherApi}&units=metric&cnt=$days';

    try {
      final response = await _apiService.request(url, type: ApiRequestType.get);
      if (response.code == 200) {
        final forecastData = ForecastData.fromJson(response.data);

        return right(forecastData);
      } else {
        return left(ServerFailure(response.message ?? 'Error happened'));
      }
    } catch (e) {
      return left(ParsingError('Parsing error: $e'));
    }
  }
}
