import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Dashboard/Controller/commands_controller.dart';
import 'package:shutter_ease/features/Dashboard/View/Commands/Widgets/commands_button.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/constants/colors.dart';

class CommandsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommandsController());
    final LocalizationController localizationController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.textColor,
        title: Text(
          localizationController.localizedValues['commands']!,
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
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 2.8,
          children: [
            CommandButton(
              icon: Icons.open_in_browser,
              text: localizationController.localizedValues['open_all']!,
              color: Colors.green,
              onTap: () async {
                await controller.openAll();
              },
            ),
            CommandButton(
              icon: Icons.close,
              text: localizationController.localizedValues['close_all']!,
              color: Colors.red,
              onTap: () async {
                await controller.closeAll();
              },
            ),
            CommandButton(
              icon: Icons.play_circle_outline,
              text: localizationController.localizedValues['play_all']!,
              color: Colors.blue,
              onTap: () async {
                await controller.playAll();
              },
            ),
            CommandButton(
              icon: Icons.stop_circle_outlined,
              text: localizationController.localizedValues['stop_all']!,
              color: Colors.orange,
              onTap: () async {
                await controller.stopAll();
              },
            ),
            CommandButton(
              icon: Icons.open_in_new,
              text: localizationController.localizedValues['open_and_stop']!,
              color: Colors.purple,
              onTap: () async {
                await controller.openAllAndStop();
              },
            ),
            CommandButton(
              icon: Icons.close_fullscreen,
              text: localizationController.localizedValues['close_and_stop']!,
              color: Colors.pink,
              onTap: () async {
                await controller.closeAllAndStop();
              },
            ),
            CommandButton(
              icon: Icons.calendar_today,
              text: localizationController.localizedValues['calendar_on']!,
              color: Colors.teal,
              onTap: () async {
                await controller.calenderON();
              },
            ),
            CommandButton(
              icon: Icons.calendar_today_outlined,
              text: localizationController.localizedValues['calendar_off']!,
              color: Colors.teal,
              onTap: () async {
                await controller.calenderOFF();
              },
            ),
          ],
        ),
      ),
    );
  }
}
