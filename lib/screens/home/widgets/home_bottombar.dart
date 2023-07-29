import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../theme/colors.dart';
import '../../../utils/extensions.dart';
import '../home_controller.dart';
import 'home_tabbar.dart';
import 'weather_data_widget.dart';

class HomeBottombar extends GetView<HomeController> {
  const HomeBottombar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.9, sigmaY: 4.9),
              child: const SizedBox(),
            ),
          ),
        ),
        Container(
          height: 325.height,
          decoration: BoxDecoration(
            gradient: AppColors.gradient1,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 25,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            borderRadius: BorderRadius.vertical(top: Radius.circular(45.width)),
          ),
          child: Column(
            children: [
              SizedBox(height: 8.height),
              Container(
                width: 48.width,
                height: 5.height,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              SizedBox(height: 12.height),
              Obx(
                () => HomeTabbar(
                  isActiveTab1: controller.isTab1Acive.value,
                  onTap: (val) {
                    controller.tabController.animateTo(val ? 0 : 1);
                    controller.isTab1Acive.value = val;
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                ),
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                decoration: const BoxDecoration(gradient: AppColors.gradient2),
              ),
              SizedBox(height: 20.height),
              _tabView(),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox _tabView() {
    return SizedBox(
      height: 156.height,
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.tabController,
        children: [
          _hourlyTab(),
          _dailyTab(),
        ],
      ),
    );
  }

  Obx _hourlyTab() {
    return Obx(
      () => ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.forecast.value?.hourlyForecast.length ?? 0,
        itemBuilder: (context, index) {
          final dayData = controller.forecast.value!.hourlyForecast[index];

          return WeatherDataWidget(
            title: index == 0 ? 'Now' : DateFormat('h a').format(dayData.date),
            icon: dayData.weatherIcon,
            temprature: dayData.temperature,
            isActive: index == 0,
          );
        },
      ),
    );
  }

  Obx _dailyTab() {
    return Obx(
      () => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.forecast.value?.daysForecast.length ?? 0,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final dayData = controller.forecast.value!.daysForecast[index];

          return WeatherDataWidget(
            title:
                index == 0 ? 'Today' : DateFormat('d MMM').format(dayData.day),
            icon: dayData.averageWeatherIcon,
            temprature: dayData.averageTemp,
            isActive: index == 0,
          );
        },
      ),
    );
  }
}
