import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../generated/l10n.dart';

extension DoubleExt on double {
  static const standardWidth = 375;
  static const standardHeight = 812;

  double get textSize {
    return this * MediaQuery.of(Get.context!).size.width / standardWidth;
  }

  double get width {
    return (this / standardWidth * 100).w;
  }

  double get height {
    return (this / standardHeight * 100).h;
  }
}

extension IntExt on int {
  static const standardWidth = 375;
  static const standardHeight = 812;

  double get textSize {
    return this * MediaQuery.of(Get.context!).size.width / standardWidth;
  }

  double get width {
    return (this / standardWidth * 100).w;
  }

  double get height {
    return (this / standardHeight * 100).h;
  }
}

extension LocalizedBuildContext on BuildContext {
  S get loc => S.of(this);
}

extension LetExtension<T> on T {
  R let<R>(R Function(T) block) {
    return block(this);
  }
}

extension ListExt<T> on List<T> {
  T? get mostOccuredOrNull {
    if (isEmpty) return null;

    final Map<T, int> occurrences = {};

    for (final item in this) {
      occurrences[item] = occurrences[item] ?? 0 + 1;
    }

    T? mostRepeatingItem;
    int maxCount = 0;

    occurrences.forEach((item, count) {
      if (count > maxCount) {
        mostRepeatingItem = item;
        maxCount = count;
      }
    });

    return mostRepeatingItem;
  }
}
