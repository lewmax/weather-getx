import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../routes.dart';
import '../../services/location_service.dart';
import '../../theme/assets.gen.dart';
import '../../theme/text_styles.dart';
import '../../utils/extensions.dart';
import '../../widgets/my_button.dart';
import 'home_controller.dart';
import 'widgets/home_bottombar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final LocationService locationService = Get.find();

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.images.bg.path,
            height: 100.h,
            width: 100.w,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            top: 51.height + Get.mediaQuery.padding.top,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(
                () => switch (locationService.permission.value) {
                  LocationPermission.denied => _button(
                      'Request location',
                      controller.getUserLoc,
                    ),
                  LocationPermission.always ||
                  LocationPermission.whileInUse =>
                    _forecast(controller),
                  (_) =>
                    _button('Open settings', Geolocator.openLocationSettings),
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:
          _button('Search City', () => Get.toNamed(Routes.search)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Column _forecast(HomeController controller) {
    return Column(
      children: [
        Text(
          controller.forecast.value?.city ?? '',
          style: AppTextStyles.size34,
        ),
        Text(
          '${controller.forecast.value?.weatherNow.temperature.round()}°',
          style: AppTextStyles.size94Light,
        ),
        const Spacer(),
        const HomeBottombar(),
      ],
    );
  }

  Widget _button(String title, Function() onTap) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.width).copyWith(
        bottom: Get.mediaQuery.padding.bottom == 0 ? 6.height : 0,
      ),
      child: MyButton(
        color: const Color.fromRGBO(72, 49, 157, 0.6),
        title: title,
        onTap: onTap,
      ),
    );
  }
}
