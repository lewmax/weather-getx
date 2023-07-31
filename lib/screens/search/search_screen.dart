import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../../models/args/home_screen_args.dart';
import '../../routes.dart';
import '../../theme/colors.dart';
import '../../theme/text_styles.dart';
import '../../utils/extensions.dart';
import '../../widgets/my_textfield.dart';
import 'search_controller.dart';
import 'widgets/city_item_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.gradient4),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          leading: InkWell(
            onTap: Get.back,
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 35.width,
              color: AppColors.grey,
            ),
          ),
          title: Text('Weather', style: AppTextStyles.size18),
        ),
        body: GetBuilder<SearchedController>(
          init: SearchedController(),
          builder: (controller) {
            return Column(
              children: [
                SizedBox(height: 15.height),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.width),
                  child: MyTextField(
                    preffixIcon:
                        const Icon(Icons.search, color: AppColors.lightGrey),
                    hintText: S.current.searchForCity,
                    controller: controller.textController,
                  ),
                ),
                Obx(
                  () {
                    final myLocFound = controller.myCity.value != null;

                    return controller.searchInProgress.value
                        ? const Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: CircularProgressIndicator(),
                          )
                        : Flexible(
                            child: ListView.builder(
                              itemCount: controller.searchResult.length,
                              itemBuilder: (context, index) {
                                final city =
                                    controller.searchResult.value[index];

                                return CityItemWidget(
                                  city: city,
                                  isMyLoc: myLocFound && index == 0,
                                  onTap: () {
                                    Get.offAllNamed(
                                      Routes.home,
                                      arguments:
                                          HomeScreenArgs(city.lat, city.lon),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
