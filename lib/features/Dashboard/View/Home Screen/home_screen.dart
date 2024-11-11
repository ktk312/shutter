import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Dashboard/Controller/device_controller.dart';
import 'package:shutter_ease/features/Dashboard/View/Drawer/drawer.dart';
import 'package:shutter_ease/features/Dashboard/View/Home%20Screen/room_card.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DeviceController deviceController = Get.put(DeviceController());
    final LocalizationController localizationController =
        Get.find<LocalizationController>();
    final mq = MediaQuery.of(context);
    print(deviceController.devices.length);

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: [
              Image.asset('assets/icons/AppLogo.png',
                  height: mq.size.height * 0.05),
              SizedBox(width: mq.size.width * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SES@MO",
                    style: TextStyle(
                        fontSize: mq.size.width * 0.07,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 1, 148, 30)),
                  ),
                  Text(
                    localizationController
                            .localizedValues['control_your_shutters'] ??
                        "Control your shutters",
                    style: TextStyle(
                        fontSize: mq.size.width * 0.04,
                        color: const Color.fromARGB(255, 1, 148, 30)),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: mq.size.width * 0.04),
              child: Center(
                child: Text(
                  localizationController.localizedValues['actions'] ??
                      "Actions",
                  style: TextStyle(
                      //color: const Color.fromARGB(255, 46, 34, 212),
                      fontWeight: FontWeight.bold,
                      fontSize: mq.size.width * 0.04),
                ),
              ),
            ),
          ],
        ),
        drawer: const CustomDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomSizedBox(height: 0.03),
              Text(
                localizationController.localizedValues['your_dashboard'] ??
                    "Your Dashboard",
                style: TextStyle(
                  fontSize: mq.size.width * 0.05,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PoppinsRegular',
                ),
              ),
              const CustomSizedBox(height: 0.02),
              Expanded(
                child: Obx(() {
                  if (deviceController.devices.isEmpty) {
                    return const Center(
                      child: Text("No devices found"),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: mq.size.width > 600 ? 3 : 2,
                      crossAxisSpacing: mq.size.width * 0.02,
                      mainAxisSpacing: mq.size.height * 0.02,
                      childAspectRatio: 0.48,
                    ),
                    itemCount: deviceController.devices.length,
                    itemBuilder: (context, index) {
                      final device = deviceController.devices[index];
                      return RoomCard(device: device);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
