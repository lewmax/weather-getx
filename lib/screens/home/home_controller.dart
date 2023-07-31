import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../models/args/home_screen_args.dart';
import '../../models/weather_data.dart';
import '../../network/repositories/weather_repository.dart';
import '../../services/location_service.dart';
import '../../utils/snackbar_utils.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final WeatherRepository _weatherRepository = Get.find();
  final LocationService _locationService = Get.find();

  //if null - try to show weather for my loc, else - show weather this Position
  final _cityLocationArgumentOrNull = Get.arguments as HomeScreenArgs?;

  late final tabController = TabController(length: 2, vsync: this);

  final forecast = Rxn<ForecastData>();
  final isTab1Acive = RxBool(true);

  @override
  Future<void> onInit() async {
    super.onInit();
    final loc = _cityLocationArgumentOrNull;
    loc == null
        ? getUserLoc(showDialogIfError: false)
        : getWeather(loc.lat, loc.lng);
  }

  Future<void> getUserLoc({bool showDialogIfError = true}) async {
    final loc =
        await _locationService.getUserLoc(showDialogIfError: showDialogIfError);
    if (loc == null) return;
    getWeather(loc.latitude, loc.longitude);
  }

  Future<void> getWeather(double lat, double lng) async {
    final failureOrWeather =
        await _weatherRepository.getForecastByLoc(lat, lng, 40);
    failureOrWeather.fold(
      (error) => SnackbarUtils.error('Error', error.message),
      (list) => forecast.value = list,
    );
  }
}
