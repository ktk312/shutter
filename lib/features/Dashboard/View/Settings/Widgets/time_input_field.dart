import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Dashboard/Controller/auto_play_controller.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

class TimeInputField extends StatelessWidget {
  final TextEditingController _timeController = TextEditingController();
  final controller = Get.put(AutoPlayController());

  TimeInputField({Key? key}) : super(key: key) {
    controller.loadAutoPlayTime();
  }

  @override
  Widget build(BuildContext context) {
    final localizationController = Get.find<LocalizationController>();

    return Obx(() {
      _timeController.text = controller.autoPlayTime.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              localizationController.localizedValues['set_auto_play_time']!,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: 120,
            child: TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: "HH:MM",
                hintText: "Enter time",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  String formattedTime = pickedTime.format(context);
                  _timeController.text = formattedTime;
                  controller.updateAutoPlayTime(formattedTime);
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
