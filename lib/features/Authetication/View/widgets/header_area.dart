import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/constants/colors.dart';

class HeaderArea extends StatelessWidget {
  const HeaderArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController = Get.find();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icons/AppLogo.png',
          width: 60,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shutter Ease",
              style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'PoppinsRegular'),
            ),
            Text(
              localizationController.localizedValues['control_your_shutters']!,
              style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 16,
                  fontFamily: 'PoppinsRegular'),
            ),
          ],
        ),
      ],
    );
  }
}
