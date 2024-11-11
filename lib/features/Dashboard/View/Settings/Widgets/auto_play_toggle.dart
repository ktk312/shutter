import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Dashboard/Controller/auto_play_controller.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

class AutoPlayToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController =
        Get.put(LocalizationController());
    final controller = Get.put(AutoPlayController());

    return FutureBuilder(
      future: controller.loadAutoPlayStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizationController.localizedValues['auto_play']!,
                style: TextStyle(fontSize: 16),
              ),
              Switch(
                value: controller.isAutoPlayEnabled.value,
                onChanged: (bool value) {
                  controller.updateAutoPlayStatus(value);
                  controller.isAutoPlayEnabled.value = value;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
