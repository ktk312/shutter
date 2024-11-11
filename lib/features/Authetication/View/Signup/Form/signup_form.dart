import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/Controller/signup_controller.dart';
import 'package:shutter_ease/features/Authetication/View/widgets/custom_button.dart';
import 'package:shutter_ease/features/Authetication/View/widgets/custom_text_field.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/Validation/validations.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController = Get.find();
    final mq = CustomMediaQuery(context);
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: controller.name,
              validator: (value) => customValidations.validateName(value),
              text: localizationController.localizedValues['name'] ?? 'Name',
            ),
            const CustomSizedBox(height: 0.02),
            CustomTextField(
              controller: controller.email,
              validator: (value) => customValidations.validateEmail(value),
              text: localizationController.localizedValues['email'] ?? 'Email',
            ),
            const CustomSizedBox(height: 0.02),
            CustomTextField(
              controller: controller.password,
              validator: (value) => customValidations.validatePassword(value),
              text: localizationController.localizedValues['password'] ??
                  'Password',
            ),
            const CustomSizedBox(height: 0.02),
            CustomTextField(
              controller: controller.confirmPassword,
              validator: (value) => customValidations.validateConfirmPassword(
                  value, controller.password.text),
              text:
                  localizationController.localizedValues['confirm_password'] ??
                      'Confirm Password',
            ),
            const CustomSizedBox(height: 0.02),
            const CustomSizedBox(height: 0.1),
            CustomButton(
              ontap: () {
                controller.userSignUp();
              },
              mq: mq,
              btNName:
                  localizationController.localizedValues['signup'] ?? 'Signup',
            ),
          ],
        ),
      ),
    );
  }
}
