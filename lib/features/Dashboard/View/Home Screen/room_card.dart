import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shutter_ease/features/Dashboard/Controller/auto_play_controller.dart';
import 'package:shutter_ease/features/Dashboard/Controller/device_controller.dart';
import 'package:shutter_ease/features/Dashboard/Model/shutter_device_model.dart';
import 'package:shutter_ease/features/Dashboard/View/Home%20Screen/Widgets/info.dart';
import 'package:shutter_ease/features/Dashboard/View/Home%20Screen/Widgets/input_dialog_for_new_data.dart';
import 'package:shutter_ease/features/Dashboard/Controller/edit_device_dialog.dart';
import 'package:shutter_ease/features/Dashboard/View/Schedule%20Screens/schedule_screen.dart';
import 'package:shutter_ease/utills/Errors/Error%20handler/error_handler.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

class RoomCard extends StatelessWidget {
  final ShutterDeviceModel device;

  const RoomCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final deviceCont = Get.put(DeviceController());
    final LocalizationController localizationController = Get.find();
    final controller = Get.put(AutoPlayController());
    controller.startAutoPlayScheduler();

    return Obx(
      () => InkWell(
        onTap: () {
          if (device.calenderStatus == true) {
            Get.to(() => ScheduleScreen(device: device));
          } else {
            ErrorHandler.showErrorToast(
                localizationController.localizedValues['calendar_off_info']!);
          }
        },
        child: Container(
          width: mq.size.width * 0.8,
          decoration: BoxDecoration(
            color: const Color(0xFF251997),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      await deviceCont
                          .toggleDeviceStatus(device.deviceId.toString());
                    },
                    child: Image.asset(
                      (device.shutterIconStatus == true && device.aParz == true)
                          ? 'assets/icons/shutterhalfOpen.png'
                          : (device.shutterIconStatus == true)
                              ? 'assets/icons/shutterOpen.png'
                              : 'assets/icons/shutterClose.png',
                      width: mq.size.width * 0.12,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.solar_power_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            (device.devicePanelOperationPercentage != null &&
                                    (device.devicePanelOperationPercentage!
                                        .isNotEmpty))
                                ? "${device.devicePanelOperationPercentage}"
                                : "0%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        ],
                      ),
                      const CustomSizedBox(width: 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            (device.wifiPercentage != null &&
                                    (device.wifiPercentage!.isNotEmpty))
                                ? "${device.wifiPercentage}"
                                : "0%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        ],
                      ),
                      const CustomSizedBox(width: 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Iconsax.battery_charging,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            (device.batteryPercentage != null &&
                                    (device.batteryPercentage!.isNotEmpty))
                                ? "${device.batteryPercentage}"
                                : "0%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'PoppinsRegular',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const CustomSizedBox(height: 0.01),
              Flexible(
                child: Text(
                  device.deviceName ?? "Nil",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: mq.size.width * 0.04,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PoppinsBold',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoRow(
                        label:
                            localizationController.localizedValues['status']!,
                        value: device.deviceStatus != null
                            ? device.deviceStatus == true
                                ? localizationController
                                    .localizedValues['play']!
                                : localizationController
                                    .localizedValues['stop']!
                            : "Nil",
                      ),
                      InfoRow(
                        label:
                            localizationController.localizedValues['f_auto']!,
                        value: device.fAuto != null
                            ? device.fAuto == true
                                ? localizationController.localizedValues['on']!
                                : localizationController.localizedValues['off']!
                            : "Nil",
                      ),
                    ],
                  ),
                  const CustomSizedBox(height: 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoRow(
                        label:
                            localizationController.localizedValues['f_crep']!,
                        value: device.fCrep != null
                            ? device.fCrep == true
                                ? localizationController.localizedValues['on']!
                                : localizationController.localizedValues['off']!
                            : "Nil",
                      ),
                      InfoRow(
                        label:
                            localizationController.localizedValues['a_parz']!,
                        value: device.aParz != null
                            ? device.aParz == true
                                ? localizationController.localizedValues['on']!
                                : localizationController.localizedValues['off']!
                            : "Nil",
                      ),
                    ],
                  ),
                  const CustomSizedBox(height: 0.02),
                  InfoRow(
                    label: localizationController.localizedValues['calendar']!,
                    value: device.calenderStatus != null
                        ? device.calenderStatus == true
                            ? localizationController.localizedValues['on']!
                            : localizationController.localizedValues['off']!
                        : "Nil",
                  ),
                ],
              ),
              const CustomSizedBox(height: 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditDevice(
                            deviceId: device.deviceId.toString(),
                            roomName: device.deviceName.toString(),
                            initialStatus: device.deviceStatus == true,
                            initialFCrep: device.fCrep == true,
                            initialFAuto: device.fAuto == true,
                            initialAParz: device.aParz == true,
                            initialCalender: device.calenderStatus == true,
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Iconsax.edit,
                          color: Colors.white.withOpacity(0.8), size: 30),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return InputDialogForNewUpdateData(
                              deviceName: device.deviceName!,
                              deviceId: device.deviceId.toString());
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Icons.settings,
                          color: Colors.white.withOpacity(0.8), size: 30),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await deviceCont.deleteShutterDevice(
                          context, device.deviceId.toString());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(Icons.delete_outline,
                          color: Colors.white.withOpacity(0.8), size: 35),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
