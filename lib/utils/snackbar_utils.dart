import 'package:get/get.dart';

import '../theme/colors.dart';

abstract class SnackbarUtils {
  static void error(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.systemRed,
      borderColor: AppColors.systemRed,
      borderWidth: 1,
      colorText: AppColors.white,
    );
  }
}
