import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Dashboard/View/Settings/Widgets/auto_play_toggle.dart';
import 'package:shutter_ease/features/Dashboard/View/Settings/Widgets/language_selector.dart';
import 'package:shutter_ease/features/Dashboard/View/Settings/Widgets/time_input_field.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController =
        Get.put(LocalizationController());

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.textColor,
          title: Text(
            localizationController.localizedValues['settings']!,
            style: TextStyle(
              fontFamily: 'PoppinsRegular',
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSectionTitle(
                  localizationController.localizedValues['language']!,
                ),
                const SizedBox(height: 10),
                LanguageSelector(),
                const Divider(height: 40, thickness: 1),
                buildSectionTitle(
                  localizationController.localizedValues['auto_play']!,
                ),
                const SizedBox(height: 10),
                AutoPlayToggle(),
                const SizedBox(height: 20),
                TimeInputField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildNumberInputField(String hint) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hint,
      ),
    );
  }
}
