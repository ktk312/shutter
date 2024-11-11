import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/View/Signin/signin_screen.dart';
import 'package:shutter_ease/features/Authetication/View/widgets/custom_button.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';

class EmailSendConfrimation extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? description;
  final String? userType;
  const EmailSendConfrimation(
      {super.key, this.title, this.subtitle, this.description, this.userType});

  @override
  Widget build(BuildContext context) {
    CustomMediaQuery mediaQuery = CustomMediaQuery(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/emailSend.png',
                  width: mediaQuery.getWidth(0.7),
                ),
                const CustomSizedBox(
                  height: 0.05,
                ),
                Text(
                  title ?? "Request sent successfully...",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 23),
                ),
                const CustomSizedBox(
                  height: 0.02,
                ),
                Text(
                  subtitle ??
                      "Thank you for registering. Your request is under review by the coordinator.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const CustomSizedBox(
                  height: 0.02,
                ),
                Text(
                  description ??
                      "You will receive an email once your registration is approved. If your request is rejected, you will not be able to log in with this email.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
                const CustomSizedBox(
                  height: 0.02,
                ),
                const Text(
                  "Important: If you do not receive the email, please check your Spam, Junk, or Promotions folder. Sometimes automated emails can be mistakenly filtered into these folders.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const CustomSizedBox(
                  height: 0.05,
                ),
                CustomButton(
                  ontap: () {
                    Get.to(() => const SigninScreen());
                  },
                  btNName: 'Continue',
                  mq: mediaQuery,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
