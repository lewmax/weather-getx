import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tesst/screens/home/home_screen.dart';

import 'generated/l10n.dart';
import 'network/api_service.dart';
import 'network/repositories/places_repository.dart';
import 'network/repositories/weather_repository.dart';
import 'routes.dart';
import 'screens/search/search_screen.dart';
import 'services/location_service.dart';
import 'theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (ctx, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Supa Chaja',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          popGesture: true,
          defaultTransition: Transition.leftToRight,
          initialRoute: Routes.home,
          getPages: [
            GetPage(name: Routes.home, page: HomeScreen.new),
            GetPage(name: Routes.search, page: () => const SearchScreen()),
          ],
          initialBinding: MainBindings(),
        );
      },
    );
  }
}

class MainBindings extends Bindings {
  final _apiService = ApiService();

  @override
  void dependencies() {
    Get
      ..put(WeatherRepository(_apiService))
      ..put(PlacesRepository(_apiService))
      ..put(LocationService());
  }
}
