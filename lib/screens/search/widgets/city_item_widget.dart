import 'package:flutter/material.dart';

import '../../../models/city_info.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_styles.dart';
import '../../../utils/extensions.dart';

class CityItemWidget extends StatelessWidget {
  const CityItemWidget({
    required this.city,
    required this.onTap,
    super.key,
    this.isMyLoc = false,
  });

  final CityInfo city;
  final bool isMyLoc;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.width),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.white,
              size: 32.width,
            ),
            SizedBox(width: 10.width),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isMyLoc ? city.displayName : city.name,
                    maxLines: 1,
                    style: AppTextStyles.size18.copyWith(color: Colors.white),
                  ),
                  Text(
                    isMyLoc ? 'From your location' : city.descr,
                    maxLines: 1,
                    style: AppTextStyles.p2Semi
                        .copyWith(color: AppColors.lightGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isMyLoc) ...[
              SizedBox(width: 10.width),
              Icon(
                Icons.location_searching_rounded,
                color: AppColors.blue,
                size: 24.width,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
