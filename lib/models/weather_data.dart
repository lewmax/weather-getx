import '../utils/extensions.dart';

class ForecastData {
  ForecastData({required this.city, required this.daysForecast});

  final String city;
  final List<DayData> daysForecast;

  WeatherData get weatherNow => daysForecast.first.weatherStamps.first;

  List<WeatherData> get hourlyForecast {
    final result = <WeatherData>[];
    daysForecast.forEach((dayData) => result.addAll(dayData.weatherStamps));

    return result;
  }
}

class DayData {
  DayData({required this.day, required this.weatherStamps});

  final List<WeatherData> weatherStamps;
  final DateTime day;

  String get averageDescr =>
      weatherStamps.map((e) => e.description).toList().mostOccuredOrNull ?? '';
  double get averageTemp {
    if (weatherStamps.isEmpty) return 0;

    double sum = 0;

    for (final double item in weatherStamps.map((e) => e.temperature)) {
      sum += item;
    }

    final double average = sum / weatherStamps.length;

    return average;
  }

  String get averageWeatherIcon =>
      weatherStamps.map((e) => e.weatherIcon).toList().mostOccuredOrNull ?? '';
}

class WeatherData {
  WeatherData({
    required this.date,
    required this.description,
    required this.temperature,
    required this.weatherIcon,
  });

  final DateTime date;
  final String description;
  final double temperature;
  final String weatherIcon;
}
