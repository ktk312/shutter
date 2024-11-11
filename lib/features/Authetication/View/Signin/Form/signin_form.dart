import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/Controller/signin_controller.dart';
import 'package:shutter_ease/features/Authetication/View/Reset%20Password/reset_password.dart';
import 'package:shutter_ease/features/Authetication/View/widgets/custom_button.dart';
import 'package:shutter_ease/features/Authetication/View/widgets/custom_text_field.dart';
import 'package:shutter_ease/utills/Validation/validations.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = CustomMediaQuery(context);
    final controller = Get.put(SigninController());
    final LocalizationController localizationController = Get.find();

    return Form(
      key: controller.signinFormKey,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: controller.email,
              validator: (value) => customValidations.validateEmail(value),
              text: localizationController.localizedValues['email']!,
            ),
            const CustomSizedBox(height: 0.02),
            CustomTextField(
              controller: controller.password,
              validator: (value) => customValidations.validatePassword(value),
              text: localizationController.localizedValues['password']!,
            ),
            const CustomSizedBox(height: 0.02),
            InkWell(
              onTap: () {
                Get.to(() => const ResetPassword());
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  localizationController
                      .localizedValues['forgot_your_password']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
              ),
            ),
            const CustomSizedBox(height: 0.1),
            CustomButton(
              ontap: () {
                controller.userSignin();
              },
              mq: mq,
              btNName: localizationController.localizedValues['signin']!,
            ),
          ],
        ),
      ),
    );
  }
}
