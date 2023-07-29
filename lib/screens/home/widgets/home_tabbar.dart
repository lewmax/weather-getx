import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../theme/text_styles.dart';
import '../../../utils/extensions.dart';

class HomeTabbar extends StatelessWidget {
  final bool isActiveTab1;
  final Function(bool val) onTap;

  const HomeTabbar({
    required this.isActiveTab1,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          bottom: 0,
          left: isActiveTab1 ? 0 : 55.w,
          duration: 200.milliseconds,
          child: Container(
            width: 110.width,
            height: 3,
            decoration: const BoxDecoration(
              gradient: AppColors.gradient3,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.width)
              .copyWith(bottom: 4.height),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => onTap(true),
                child: Text(
                  'Hourly Forecast',
                  style: AppTextStyles.p1Semi.copyWith(color: AppColors.grey),
                ),
              ),
              InkWell(
                onTap: () => onTap(false),
                child: Text(
                  'Daily Forecast',
                  style: AppTextStyles.p1Semi.copyWith(color: AppColors.grey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
