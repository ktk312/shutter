import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/data/repository/authentication_repository.dart';
import 'package:shutter_ease/data/repository/user_repository.dart';
import 'package:shutter_ease/features/Dashboard/Controller/commands_controller.dart';
import 'package:shutter_ease/features/Dashboard/View/Commands/commands_screen.dart';
import 'package:shutter_ease/features/Dashboard/View/Device%20Screens/device_form.dart';
import 'package:shutter_ease/features/Dashboard/View/Drawer/Widgets/drawer_item.dart';
import 'package:shutter_ease/features/Dashboard/View/Settings/setting_screen.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/constants/colors.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';
import 'package:shutter_ease/utills/helper/Time%20Controller/time_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepo = Get.put(UserRepository());
    final timeController = Get.put(TimeController());
    final authRepo = Get.put(AuthenticationRepository());
    final deviceController = Get.put(CommandsController());
    final LocalizationController localizationController = Get.find();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final userData = userRepo.userData;
            final name = userData['name'] ?? 'User Name';
            final email = userData['email'] ?? 'user@example.com';

            return Container(
              color: AppColors.textColor,
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Row(
                  children: [
                    const SizedBox(height: 50),
                  Text(
                    "",
                    style: const TextStyle(
                    fontFamily: 'PoppinsRegular'),
                  ),
                    const CustomSizedBox(
                      width: 0.05,
                      height: 0.1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'PoppinsRegular',
                          ),
                        ),
                        const CustomSizedBox(
                          width: 0.05,
                          height: 0.001,),
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontFamily: 'PoppinsRegular',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          Expanded(
            child: Obx(
              () => ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                children: [
                  DrawerItem(
                    icon: Icons.add_circle_outline,
                    text: localizationController.localizedValues['add_device']!,
                    onTap: () {
                      Get.to(() => DeviceForm());
                    },
                  ),
                  DrawerItem(
                    icon: Icons.featured_play_list_outlined,
                    text: localizationController.localizedValues['commands']!,
                    onTap: () {
                      Get.to(CommandsPage());
                    },
                  ),
                  DrawerItem(
                    icon: Icons.open_in_new_outlined,
                    text: localizationController.localizedValues['play_all']!,
                    onTap: () async {
                      await deviceController.playAll();
                    },
                  ),
                  DrawerItem(
                    icon: Icons.close,
                    text: localizationController.localizedValues['stop_all']!,
                    onTap: () async {
                      await deviceController.stopAll();
                    },
                  ),
                  DrawerItem(
                    icon: Icons.schedule,
                    text:
                        localizationController.localizedValues['calendar_on']!,
                    onTap: () async {
                      await deviceController.calenderON();
                    },
                  ),
                  DrawerItem(
                    icon: Icons.settings_outlined,
                    text: localizationController.localizedValues['settings']!,
                    onTap: () {
                      Get.to(SettingsScreen());
                    },
                  ),
                  DrawerItem(
                    icon: Icons.logout,
                    text: localizationController.localizedValues['sign_out']!,
                    onTap: () {
                      authRepo.signOutWarningPopup();
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    //color: Colors.black54,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${localizationController.localizedValues['date']}: ${timeController.currentDate.toString()}",
                    style: const TextStyle(
                        //color: Color.fromARGB(255, 37, 37, 37),
                        fontFamily: 'PoppinsRegular'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${localizationController.localizedValues['time_label']}: ${timeController.currentTime.toString()}",
                    style: const TextStyle(
                        //color: Color.fromARGB(255, 63, 63, 63),
                        fontFamily: 'PoppinsRegular'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "",
                    style: const TextStyle(
                        fontFamily: 'PoppinsRegular'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
