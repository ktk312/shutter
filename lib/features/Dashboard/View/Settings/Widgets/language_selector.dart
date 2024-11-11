import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizationController = Get.find<LocalizationController>();

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            localizationController.localizedValues['language_code'] ??
                'Default Language',
            style: TextStyle(fontSize: 16),
          ),
          DropdownButton<String>(
            value: localizationController.languageCode == 'en'
                ? 'English'
                : 'Italian',
            items: const [
              DropdownMenuItem(value: 'English', child: Text('English')),
              DropdownMenuItem(value: 'Italian', child: Text('Italiano')),
            ],
            onChanged: (String? newValue) {
              localizationController.changeLanguage(
                newValue!.toLowerCase() == 'english' ? 'en' : 'it',
              );
            },
          ),
        ],
      ),
    );
  }
}
