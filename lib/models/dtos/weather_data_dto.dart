import '../weather_data.dart';

class ForecastDataDto {
  const ForecastDataDto._({
    required this.city,
    required this.daysForecast,
  });
  final String city;
  final List<DayDataDto> daysForecast;

  static ForecastDataDto fromJson(Map<String, dynamic> json) {
    final List<dynamic> weatherDataJsonList = json['list'];

    final List<WeatherDataDto> weatherDataList =
        weatherDataJsonList.map((e) => WeatherDataDto.fromJson(e)).toList();

    final Map<DateTime, List<WeatherDataDto>> groupedWeatherData = {};

    for (WeatherDataDto weatherData in weatherDataList) {
      final DateTime dateKey = DateTime(
        weatherData.date.year,
        weatherData.date.month,
        weatherData.date.day,
      );

      if (!groupedWeatherData.containsKey(dateKey)) {
        groupedWeatherData[dateKey] = [];
      }

      groupedWeatherData[dateKey]!.add(weatherData);
    }

    final List<DayData> dayDataList = groupedWeatherData.entries.map((entry) {
      return DayData(
        day: entry.key,
        weatherStamps: entry.value.map((e) => e.toDomain()).toList(),
      );
    }).toList();

    return ForecastDataDto._(
      city: json['city']['name'],
      daysForecast: dayDataList.map(DayDataDto.fromDomain).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'daysForecast': daysForecast,
    };
  }

  static ForecastDataDto fromDomain(ForecastData domain) {
    return ForecastDataDto._(
      city: domain.city,
      daysForecast: domain.daysForecast.map(DayDataDto.fromDomain).toList(),
    );
  }

  ForecastData toDomain() {
    return ForecastData(
      city: city,
      daysForecast: daysForecast.map((e) => e.toDomain()).toList(),
    );
  }
}

class DayDataDto {
  const DayDataDto._({
    required this.weatherStamps,
    required this.day,
  });
  final List<WeatherDataDto> weatherStamps;
  final DateTime day;

  static DayDataDto fromJson(Map<String, dynamic> json) {
    return DayDataDto._(
      weatherStamps: json['weatherStamps'],
      day: json['day'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weatherStamps': weatherStamps,
      'day': day,
    };
  }

  static DayDataDto fromDomain(DayData domain) {
    return DayDataDto._(
      weatherStamps:
          domain.weatherStamps.map(WeatherDataDto.fromDomain).toList(),
      day: domain.day,
    );
  }

  DayData toDomain() {
    return DayData(
      weatherStamps: weatherStamps.map((e) => e.toDomain()).toList(),
      day: day,
    );
  }
}

class WeatherDataDto {
  const WeatherDataDto._({
    required this.date,
    required this.description,
    required this.temperature,
    required this.weatherIcon,
  });
  final DateTime date;
  final String description;
  final double temperature;
  final String weatherIcon;

  static WeatherDataDto fromJson(Map<String, dynamic> json) {
    return WeatherDataDto._(
      date: DateTime.parse(json['dt_txt']),
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      weatherIcon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'description': description,
      'temperature': temperature,
      'weatherIcon': weatherIcon,
    };
  }

  static WeatherDataDto fromDomain(WeatherData domain) {
    return WeatherDataDto._(
      date: domain.date,
      description: domain.description,
      temperature: domain.temperature,
      weatherIcon: domain.weatherIcon,
    );
  }

  WeatherData toDomain() {
    return WeatherData(
      date: date,
      description: description,
      temperature: temperature,
      weatherIcon: weatherIcon,
    );
  }
}
