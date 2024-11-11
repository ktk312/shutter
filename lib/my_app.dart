import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/View/Splash%20Screen/splash_screen.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/localization/localization.dart';
import 'package:shutter_ease/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocalizationController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ses@mo',
      theme: lightMode,
      darkTheme: darkMode,
      home: const SplashScreen(),
      locale: Locale(controller.languageCode),
      translations: Localization(),
      initialBinding: BindingsBuilder(() {
        Get.put(LocalizationController());
      }),
    );
  }
}
