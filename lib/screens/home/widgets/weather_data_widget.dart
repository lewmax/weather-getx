import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../models/weather_data.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_styles.dart';
import '../../../utils/constants.dart';
import '../../../utils/extensions.dart';

class WeatherDataWidget extends StatelessWidget {
  final String title;
  final String icon;
  final double temprature;
  final bool isActive;

  const WeatherDataWidget({
    required this.title,
    required this.icon,
    required this.temprature,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.width,
      height: 146.height,
      padding: EdgeInsets.symmetric(vertical: 14.height),
      margin: EdgeInsets.symmetric(horizontal: 7.width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        color: isActive
            ? AppColors.purple
            : const Color.fromRGBO(72, 49, 157, 0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(5, 4),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.25),
            offset: const Offset(1, 1),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.p2Semi,
          ),
          Image.network(
            AppConstants.icon(icon),
            width: 50.width,
            height: 50.width,
          ),
          Text(
            '${temprature.round()}°',
            style: AppTextStyles.p2Semi,
          ),
        ],
      ),
    );
  }
}
