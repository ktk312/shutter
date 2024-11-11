import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/View/Signin/Form/signin_form.dart';
import 'package:shutter_ease/features/Authetication/View/Signup/signup_screen.dart';
import 'package:shutter_ease/features/Authetication/View/widgets/header_area.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

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
                const HeaderArea(),
                const CustomSizedBox(height: 0.1),
                Text(
                  localizationController.localizedValues['login_here']!,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
                const CustomSizedBox(height: 0.02),
                Text(
                  localizationController.localizedValues['welcome_back']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'PoppinsRegular',
                  ),
                ),
                const CustomSizedBox(height: 0.1),
                const SigninForm(),
                const CustomSizedBox(height: 0.02),
                const CustomSizedBox(height: 0.06),
                InkWell(
                  onTap: () {
                    Get.offAll(() => const SignupScreen());
                  },
                  child: Text(
                    localizationController
                        .localizedValues['create_new_account']!,
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
