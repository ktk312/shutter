import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/View/Signin/signin_screen.dart';
import 'package:shutter_ease/features/Authetication/View/Signup/Form/signup_form.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController = Get.find();
    return Obx(
      () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomSizedBox(height: 0.04),
                Text(
                  localizationController.localizedValues['create_account'] ??
                      "Create Account",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
                const CustomSizedBox(height: 0.02),
                Text(
                  localizationController
                          .localizedValues['create_account_desc'] ??
                      "Create an account so you can explore all the existing jobs",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
                const CustomSizedBox(height: 0.08),
                const SignupForm(),
                const CustomSizedBox(height: 0.06),
                InkWell(
                  onTap: () {
                    Get.to(() => const SigninScreen());
                  },
                  child: Text(
                    localizationController
                            .localizedValues['already_have_account'] ??
                        "Already have an account?",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'PoppinsRegular',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
