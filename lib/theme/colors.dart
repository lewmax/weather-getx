import 'package:flutter/material.dart';

final appTheme = ThemeData(
  fontFamily: 'SFProDisplay',
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.white,
    ),
  ),
);

abstract class AppColors {
  static const primary = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const purple = Color(0xFF48319D);

  static const red = Color(0xFFE44848);
  static const systemRed = Color(0xFFB42E2E);
  static const blue = Color(0xFF24BBEF);

  static const grey = Color(0xFFEBEBF5);
  static const lightGrey = Color.fromRGBO(235, 235, 245, 0.6);
  static const darkGrey3 = Color(0xFF1A1B1E);
  static const middleGrey = Color(0xFF222630);

  static const gradient1 = LinearGradient(
    colors: [
      Color.fromRGBO(46, 51, 90, 0.26),
      Color.fromRGBO(28, 27, 51, 0.26),
    ],
    stops: [0.0, 1.0],
    transform: GradientRotation(138),
  );

  static const gradient2 = LinearGradient(
    colors: [Color(0xFF2E335A), Color(0xFF1C1B33)],
  );

  static const gradient3 = LinearGradient(
    colors: [
      Color(0x00FFFFFF),
      Colors.white70,
      Color(0x00FFFFFF),
    ],
    stops: [0.5639, 0.7819, 0.9677],
    transform: GradientRotation(270),
  );
  static const gradient4 = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFF2E335A), Color(0xFF1C1B33)],
    stops: [0.0, 1.0],
  );
  static const gradient5 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF2E335A),
      Color(0xFF1C1B33),
    ],
    stops: [0.0, 1.0],
  );
}
