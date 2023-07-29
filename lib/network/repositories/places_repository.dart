import 'package:dartz/dartz.dart';

import '../../models/city_info.dart';
import '../api_constants.dart';
import '../api_service.dart';
import '../failures.dart';

class PlacesRepository {
  PlacesRepository(this._apiService);

  final ApiService _apiService;

  Future<Either<Failure, List<CityInfo>>> fetchCities(String cityName) async {
    final url =
        '${WeatherApiConstants.placesUrl}?city=$cityName&format=json&accept-language=en';

    try {
      final response = await _apiService.request(url, type: ApiRequestType.get);
      if (response.code == 200) {
        final List data = response.data;
        final cities = data.map((e) => CityInfo.fromJson(e)).toList();

        return right(cities);
      } else {
        return left(ServerFailure(response.message ?? 'Error happened'));
      }
    } catch (e) {
      return left(ParsingError('Parsing error: $e'));
    }
  }

  Future<Either<Failure, CityInfo>> getCityInfoByLocation(
    double latitude,
    double longitude,
  ) async {
    //zoom = 10 for searching only for cities
    final url =
        '${WeatherApiConstants.placesReverseUrl}?format=json&accept-language=en&lat=$latitude&lon=$longitude&zoom=10';

    try {
      final response = await _apiService.request(url, type: ApiRequestType.get);
      if (response.code == 200) {
        final cityInfo = CityInfo.fromJson(response.data);

        return right(cityInfo);
      } else {
        return left(ServerFailure(response.message ?? 'Error happened'));
      }
    } catch (e) {
      return left(ParsingError('Parsing error: $e'));
    }
  }
}
