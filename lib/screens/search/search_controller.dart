import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../models/city_info.dart';
import '../../network/repositories/places_repository.dart';
import '../../services/location_service.dart';
import '../../utils/snackbar_utils.dart';

class SearchedController extends GetxController {
  final PlacesRepository _placesRepository = Get.find();
  final LocationService _locationService = Get.find();

  final textController = TextEditingController();
  final _debouncer = Debouncer(delay: 800.milliseconds);
  final searchInProgress = false.obs;
  final cities = RxList<CityInfo>();
  final myCity = Rxn<CityInfo>();

  RxList<CityInfo> get searchResult => RxList<CityInfo>(
        [
          if (myCity.value != null) myCity.value!,
          ...cities.value,
        ],
      );

  @override
  void onInit() {
    super.onInit();
    _getMyCity();
    textController.addListener(
      () => _debouncer.call(() async => await _search(textController.text)),
    );
  }

  Future<void> _search(String text) async {
    if (text.length < 3) return;
    searchInProgress.value = true;
    final result = await _placesRepository.searchCities(text);
    searchInProgress.value = false;
    result.fold(
      (failure) => SnackbarUtils.error('Issue happened', 'Try again'),
      (citiesRes) {
        cities.value = citiesRes;
        if (citiesRes.isNotEmpty) return;
        SnackbarUtils.error('No results found', 'Try something else');
      },
    );
  }

  Future<void> _getMyCity() async {
    if (_locationService.permission.value
        case LocationPermission.always || LocationPermission.whileInUse) {
      final userLoc =
          await _locationService.getUserLoc(showDialogIfError: false);
      if (userLoc == null) return;
      final failureOrCity = await _placesRepository.getCityInfoByLocation(
        userLoc.latitude,
        userLoc.longitude,
      );
      failureOrCity.fold(
        (failure) =>
            SnackbarUtils.error('Error happened', 'City not fetch your city'),
        (cityInfo) => myCity.value = cityInfo,
      );
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
