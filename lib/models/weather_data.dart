import '../utils/extensions.dart';

class ForecastData {
  ForecastData(this.city, this.daysForecast);

  final String city;
  final List<DayData> daysForecast;

  WeatherData get weatherNow => daysForecast.first.weatherStamps.first;

  List<WeatherData> get hourlyForecast {
    final result = <WeatherData>[];
    daysForecast.forEach((dayData) => result.addAll(dayData.weatherStamps));

    return result;
  }

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> weatherDataJsonList = json['list'];

    List<WeatherData> weatherDataList = weatherDataJsonList
        .map((weatherDataJson) => WeatherData.fromJson(weatherDataJson))
        .toList();

    Map<DateTime, List<WeatherData>> groupedWeatherData = {};

    for (WeatherData weatherData in weatherDataList) {
      DateTime dateKey = DateTime(
        weatherData.date.year,
        weatherData.date.month,
        weatherData.date.day,
      );

      if (!groupedWeatherData.containsKey(dateKey)) {
        groupedWeatherData[dateKey] = [];
      }

      groupedWeatherData[dateKey]!.add(weatherData);
    }

    List<DayData> dayDataList = groupedWeatherData.entries.map((entry) {
      return DayData(
        day: entry.key,
        weatherStamps: entry.value,
      );
    }).toList();

    return ForecastData(
      json['city']['name'],
      dayDataList,
    );
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

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: DateTime.parse(json['dt_txt']),
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      weatherIcon: json['weather'][0]['icon'],
    );
  }
}
