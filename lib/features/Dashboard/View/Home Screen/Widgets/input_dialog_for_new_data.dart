import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/Errors/Error%20handler/error_handler.dart';
import 'package:shutter_ease/utills/constants/colors.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';
import '../../../Controller/device_controller.dart';

class InputDialogForNewUpdateData extends StatefulWidget {
  final String deviceId;
  final String deviceName;

  InputDialogForNewUpdateData({
    Key? key,
    required this.deviceId,
    required this.deviceName,
  }) : super(key: key);

  @override
  _InputDialogForNewUpdateDataState createState() =>
      _InputDialogForNewUpdateDataState();
}

class _InputDialogForNewUpdateDataState
    extends State<InputDialogForNewUpdateData> {
  late TextEditingController sleepTimeController;
  late TextEditingController openingEffort1Controller;
  late TextEditingController openingEffort2Controller;
  late TextEditingController openingEffort3Controller;
  late TextEditingController closingEffort1Controller;
  late TextEditingController closingEffort2Controller;
  late TextEditingController closingEffort3Controller;
  late TextEditingController deviceNameController;

  bool isLoading = true;
  
  String? get deviceName => null;

  @override
  void initState() {
    super.initState();
    sleepTimeController = TextEditingController();
    openingEffort1Controller = TextEditingController();
    openingEffort2Controller = TextEditingController();
    openingEffort3Controller = TextEditingController();
    closingEffort1Controller = TextEditingController();
    closingEffort2Controller = TextEditingController();
    closingEffort3Controller = TextEditingController();
    deviceNameController = TextEditingController();
    fetchDeviceData();
  }

  @override
  void dispose() {
    sleepTimeController.dispose();
    openingEffort1Controller.dispose();
    openingEffort2Controller.dispose();
    openingEffort3Controller.dispose();
    closingEffort1Controller.dispose();
    closingEffort2Controller.dispose();
    closingEffort3Controller.dispose();
    deviceNameController.dispose();
    super.dispose();
  }

  Future<void> fetchDeviceData() async {
    try {
      final dataSnapshot = await FirebaseDatabase.instance
          .ref('ShutterDevices/${widget.deviceId}')
          .get();
      if (dataSnapshot.exists) {
        final data = dataSnapshot.value as Map;
        if (Platform.isIOS) {
          var item = {};
          data.entries.forEach((element) {
            if (element.key == widget.deviceId) {
              print(element);
              item = element.value;
            }
          });
          setState(() {
            sleepTimeController.text = item['sleepTime']?.toString() ?? '';
            openingEffort1Controller.text =
                item['openingEffort1']?.toString() ?? '';
            openingEffort2Controller.text =
                item['openingEffort2']?.toString() ?? '';
            openingEffort3Controller.text =
                item['openingEffort3']?.toString() ?? '';
            closingEffort1Controller.text =
                item['closingEffort1']?.toString() ?? '';
            closingEffort2Controller.text =
                item['closingEffort2']?.toString() ?? '';
            closingEffort3Controller.text =
                item['closingEffort3']?.toString() ?? '';
            isLoading = false;
            deviceNameController.text = item['deviceName']?.toString() ?? '';
          });
        } else {
          setState(() {
            sleepTimeController.text = data['sleepTime']?.toString() ?? '';
            openingEffort1Controller.text =
                data['openingEffort1']?.toString() ?? '';
            openingEffort2Controller.text =
                data['openingEffort2']?.toString() ?? '';
            openingEffort3Controller.text =
                data['openingEffort3']?.toString() ?? '';
            closingEffort1Controller.text =
                data['closingEffort1']?.toString() ?? '';
            closingEffort2Controller.text =
                data['closingEffort2']?.toString() ?? '';
            closingEffort3Controller.text =
                data['closingEffort3']?.toString() ?? '';
            deviceNameController.text = data['deviceName']?.toString() ?? '';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      ErrorHandler.showErrorSnackbar('Failed to fetch data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeviceController());
    final LocalizationController localizationController =
        Get.put(LocalizationController());
    return Obx(
      () => AlertDialog(
        title: Text(
          widget.deviceName,
          style: TextStyle(
              fontSize: 18,
              color: AppColors.textColor,
              fontWeight: FontWeight.bold),
        ),
        content: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    buildTextField(
                        localizationController.localizedValues['sleep_time']!,
                        sleepTimeController),
                    buildTextField(
                        localizationController
                            .localizedValues['opening_effort_1']!,
                        openingEffort1Controller),
                    buildTextField(
                        localizationController
                            .localizedValues['opening_effort_2']!,
                        openingEffort2Controller),
                    buildTextField(
                        localizationController
                            .localizedValues['opening_effort_3']!,
                        openingEffort3Controller),
                    buildTextField(
                        localizationController
                            .localizedValues['closing_effort_1']!,
                        closingEffort1Controller),
                    buildTextField(
                        localizationController
                            .localizedValues['closing_effort_2']!,
                        closingEffort2Controller),
                    buildTextField(
                        localizationController
                            .localizedValues['closing_effort_3']!,
                        closingEffort3Controller),
                    buildTextField(
                        localizationController.localizedValues['device_name']!,
                        deviceNameController),
                  ],
                ),
              ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      localizationController.localizedValues['cancel']!,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomSizedBox(
                    width: 0.01,
                  ),
                  InkWell(
                    onTap: () async {
                      int? sleepTime =
                          int.tryParse(sleepTimeController.text.trim());
                      int? openingEffort1 =
                          int.tryParse(openingEffort1Controller.text.trim());
                      int? openingEffort2 =
                          int.tryParse(openingEffort2Controller.text.trim());
                      int? openingEffort3 =
                          int.tryParse(openingEffort3Controller.text.trim());
                      int? closingEffort1 =
                          int.tryParse(closingEffort1Controller.text.trim());
                      int? closingEffort2 =
                          int.tryParse(closingEffort2Controller.text.trim());
                      int? closingEffort3 =
                          int.tryParse(closingEffort3Controller.text.trim());
                      String? deviceName =
                          deviceNameController.text.trim();

                      if (sleepTime != null &&
                          openingEffort1 != null &&
                          openingEffort2 != null &&
                          openingEffort3 != null &&
                          closingEffort1 != null &&
                          closingEffort2 != null &&
                          closingEffort3 != null) {
                        await controller.updateDeviceNewData(
                          widget.deviceId,
                          sleepTime,
                          openingEffort1,
                          openingEffort2,
                          openingEffort3,
                          closingEffort1,
                          closingEffort2,
                          closingEffort3,
                          deviceName,
                        );
                        Navigator.pop(context);
                      } else {
                        ErrorHandler.showErrorSnackbar(
                          'Please enter valid integer values.',
                        );
                      }
                    },
                    child: Text(
                      localizationController.localizedValues['save_device']!,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              CustomSizedBox(
                height: 0.02,
              ),
              InkWell(
                onTap: () {
                  DeviceController.instance.resetAlarm(widget.deviceId);
                  Navigator.pop(context);
                },
                child: Text(
                  localizationController.localizedValues['alarm_reset']!,
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
