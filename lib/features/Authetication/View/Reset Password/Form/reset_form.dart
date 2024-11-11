import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/Controller/reset_password_controller.dart';
import 'package:shutter_ease/features/Authetication/View/widgets/custom_button.dart';
import 'package:shutter_ease/features/Authetication/View/widgets/custom_text_field.dart';
import 'package:shutter_ease/utills/Validation/validations.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    super.key,
    required this.controller,
  });

  final ResetPasswordController controller;

  @override
  Widget build(BuildContext context) {
    final mq = CustomMediaQuery(context);
    final LocalizationController localizationController = Get.find();

    return Form(
      key: controller.resetFormkey,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: controller.email,
              validator: (value) => customValidations.validateEmail(value),
              text: localizationController.localizedValues['email']!,
            ),
            const CustomSizedBox(
              height: 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                localizationController.localizedValues['reset_password_info']!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            const CustomSizedBox(
              height: .13,
            ),
            CustomButton(
              btNName:
                  localizationController.localizedValues['reset_password']!,
              ontap: () {
                controller.resetPassword();
              },
              mq: mq,
            )
          ],
        ),
      ),
    );
  }
}
