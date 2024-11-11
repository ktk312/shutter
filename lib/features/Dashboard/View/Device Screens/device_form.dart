import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/View/widgets/custom_button.dart';
import 'package:shutter_ease/features/Dashboard/Controller/device_controller.dart';
import 'package:shutter_ease/features/Dashboard/View/Device%20Screens/Widgets/upper_case_formater.dart';
import 'package:shutter_ease/features/Dashboard/View/Device%20Screens/Widgets/device_text_field.dart';
import 'package:shutter_ease/utills/Validation/validations.dart';
import 'package:shutter_ease/utills/constants/colors.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

class DeviceForm extends StatelessWidget {
  final DeviceController controller = Get.put(DeviceController());

  DeviceForm({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = CustomMediaQuery(context);
    final LocalizationController localizationController = Get.find();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.textColor,
          title: Text(
            localizationController.localizedValues['add_device']!,
            style: const TextStyle(
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Form(
            key: controller.deviceFormKey,
            child: ListView(
              children: [
                CustomdeviceInputField(
                  label: localizationController.localizedValues['device_name']!,
                  icon: Icons.device_hub,
                  controller: controller.deviceNameController,
                  validator: (value) =>
                      customValidations.validateEmptyText('Device Name', value),
                ),
                const CustomSizedBox(height: 0.02),
                CustomdeviceInputField(
                  label: localizationController.localizedValues['mac_address']!,
                  icon: Icons.wifi,
                  controller: controller.macAddressController,
                  validator: (value) =>
                      customValidations.validateMacAddress(value),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(12),
                    UpperCaseTextFormatter(),
                  ],
                ),
                const CustomSizedBox(height: 0.02),
                Text(
                  localizationController.localizedValues['type']!,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                const CustomSizedBox(height: 0.01),
                Obx(() => Column(
                      children: [
                        RadioListTile<String>(
                          title: Text(localizationController.localizedValues['Single']!),
                          value: 'Single',
                          groupValue: controller.shutterType.value,
                          onChanged: (value) {
                            controller.shutterType.value = value!;
                          },
                        ),
                        RadioListTile<String>(
                          title: Text(localizationController.localizedValues['Double']!),
                          value: 'Double',
                          groupValue: controller.shutterType.value,
                          onChanged: (value) {
                            controller.shutterType.value = value!;
                          },
                        ),
                        RadioListTile<String>(
                          title: Text(localizationController.localizedValues['Double Interlocking']!),
                          value: 'Double Interlocking',
                          groupValue: controller.shutterType.value,
                          onChanged: (value) {
                            controller.shutterType.value = value!;
                          },
                        ),
                      ],
                    )),
                const CustomSizedBox(height: 0.02),
                Text(
                  localizationController.localizedValues['priority']!,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                const CustomSizedBox(height: 0.01),
                Obx(() => Column(
                      children: [
                        RadioListTile<String>(
                          title: Text(localizationController.localizedValues['Right']!),
                          value: 'Right',
                          groupValue: controller.priority.value,
                          onChanged: (value) {
                            controller.priority.value = value!;
                          },
                        ),
                        RadioListTile<String>(
                          title: Text(localizationController.localizedValues['Left']!),
                          value: 'Left',
                          groupValue: controller.priority.value,
                          onChanged: (value) {
                            controller.priority.value = value!;
                          },
                        ),
                      ],
                    )),
                const CustomSizedBox(height: 0.02),
                Text(
                  localizationController.localizedValues['motors']!,
                  style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
                const CustomSizedBox(height: 0.01),
                Obx(() => Column(
                      children: [
                        RadioListTile<int>(
                          title: Text(localizationController.localizedValues['1']!),
                          value: 1,
                          groupValue: controller.numberOfMotors.value,
                          onChanged: (value) {
                            controller.numberOfMotors.value = value!;
                          },
                        ),
                        RadioListTile<int>(
                          title: Text(localizationController.localizedValues['2']!),
                          value: 2,
                          groupValue: controller.numberOfMotors.value,
                          onChanged: (value) {
                            controller.numberOfMotors.value = value!;
                          },
                        ),
                      ],
                    )),
                const CustomSizedBox(
                  height: 0.05,
                ),
                CustomButton(
                  mq: mq,
                  ontap: () async {
                    await controller.saveShutterDevice();
                  },
                  btNName:
                      localizationController.localizedValues['save_device']!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
