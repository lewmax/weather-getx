import 'package:flutter/material.dart';
import '../utils/extensions.dart';

abstract class AppTextStyles {
  static final h1 =
      TextStyle(fontSize: 40.0.textSize, fontWeight: FontWeight.w700);

  //94
  static final size94 =
      TextStyle(fontSize: 94.textSize, fontWeight: FontWeight.w400);
  static final size94Light = size94.copyWith(fontWeight: FontWeight.w200);

  //34
  static final size34 =
      TextStyle(fontSize: 34.textSize, fontWeight: FontWeight.w400);
  static final size34Semi = size34.copyWith(fontWeight: FontWeight.w500);

  //24
  static final h2 =
      TextStyle(fontSize: 24.0.textSize, fontWeight: FontWeight.w400);
  static final h2Bold = h2.copyWith(fontWeight: FontWeight.w700);

  //18
  static final size18 =
      TextStyle(fontSize: 18.0.textSize, fontWeight: FontWeight.w400);

  //16
  static final p1 =
      TextStyle(fontSize: 16.0.textSize, fontWeight: FontWeight.w400);
  static final p1Plus = p1.copyWith(fontWeight: FontWeight.w500);
  static final p1Semi = p1.copyWith(fontWeight: FontWeight.w600);
  static final p1Bold = p1.copyWith(fontWeight: FontWeight.w700);

  //15
  static final size15 =
      TextStyle(fontSize: 15.0.textSize, fontWeight: FontWeight.w400);
  static final size15Semi = size15.copyWith(fontWeight: FontWeight.w600);
  static final size15Bold = size15.copyWith(fontWeight: FontWeight.w700);

  //14
  static final p2 =
      TextStyle(fontSize: 14.0.textSize, fontWeight: FontWeight.w400);
  static final p2Semi = p2.copyWith(fontWeight: FontWeight.w600);
  static final p2Bold = p2.copyWith(fontWeight: FontWeight.w800);

  //12
  static final size12 =
      TextStyle(fontSize: 12.0.textSize, fontWeight: FontWeight.w400);
  static final size12Semi = size15.copyWith(fontWeight: FontWeight.w600);
  static final size12Bold = size15.copyWith(fontWeight: FontWeight.w700);

  //10
  static final size10 =
      TextStyle(fontSize: 10.0.textSize, fontWeight: FontWeight.w400);
  static final size10Semi = size15.copyWith(fontWeight: FontWeight.w600);
  static final size10Bold = size15.copyWith(fontWeight: FontWeight.w700);
}
