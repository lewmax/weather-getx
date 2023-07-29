import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../generated/l10n.dart';
import '../widgets/my_dialog.dart';

class LocationService extends GetxService {
  final permission = LocationPermission.unableToDetermine.obs;

  Future<Position?> getUserLoc({bool showDialogIfError = true}) async {
    final locGranted =
        await _requestLocation(showDialogIfError: showDialogIfError);
    if (!locGranted) return null;
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }

  Future<bool> _requestLocation({bool showDialogIfError = true}) async {
    permission.value = await Geolocator.checkPermission();
    if (permission.value == LocationPermission.always ||
        permission.value == LocationPermission.whileInUse) {
      // Permission already granted
      return true;
    } else if (permission.value == LocationPermission.deniedForever) {
      if (showDialogIfError) _showDialog();

      return false;
    } else {
      permission.value = await Geolocator.requestPermission();
      if (permission.value == LocationPermission.always ||
          permission.value == LocationPermission.whileInUse) {
        return true;
      }
    }

    return false;
  }

  void _showDialog({String? title, String? subTitle}) {
    Get.dialog(
      DialogWidget(
        title: title ?? S.current.locationPermissionDenied,
        subtitle: subTitle ?? S.current.giveTheLocationPermission,
        button2: S.current.navigate,
        onTap2: () async {
          Geolocator.openLocationSettings();
          Get.back();
        },
      ),
    );
  }
}
