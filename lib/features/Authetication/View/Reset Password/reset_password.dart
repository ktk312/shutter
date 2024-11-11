import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/Controller/reset_password_controller.dart';
import 'package:shutter_ease/features/Authetication/View/Reset%20Password/Form/reset_form.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';

class ResetPassword extends StatelessWidget {
  final String? userType;
  const ResetPassword({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    final mq = CustomMediaQuery(context);
    final LocalizationController localizationController = Get.find();

    return Obx(
      () => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 0),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios)),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: mq.getHeight(0.12)),
                      Image.asset(
                        'assets/icons/reset-password.png',
                        width: mq.getWidth(0.33),
                      ),
                      const CustomSizedBox(
                        height: 0.05,
                      ),
                      Text(
                        localizationController
                            .localizedValues['reset_password']!,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PoppinsBold'),
                      ),
                      const CustomSizedBox(
                        height: 0.02,
                      ),
                      Text(
                        localizationController
                            .localizedValues['reset_password_description']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'PoppinsRegular'),
                      ),
                      const CustomSizedBox(
                        height: 0.04,
                      ),
                      ResetPasswordForm(controller: controller),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
