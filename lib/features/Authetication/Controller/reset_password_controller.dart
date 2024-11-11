import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/data/repository/authentication_repository.dart';
import 'package:shutter_ease/features/Authetication/View/Reset%20Password/email_send_confrimation.dart';
import 'package:shutter_ease/utills/Errors/Error%20handler/error_handler.dart';
import 'package:shutter_ease/utills/helper/Popups/screen_loader.dart';

class ResetPasswordController extends GetxController {
  static ResetPasswordController get instance => Get.find();

  GlobalKey<FormState> resetFormkey = GlobalKey<FormState>();

  final authRepo = Get.put(AuthenticationRepository());

  final email = TextEditingController();

  void resetPassword() async {
    try {
      // Start loading
      FullScreenLoader.openLoadingDialog('We are processing your information',
          'assets/files/processignAnimation.json');

      // Form validation
      if (!resetFormkey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Get the formatted email
      String formattedEmail = email.text.trim().toLowerCase();

      // Realtime Database reference
      DatabaseReference usersRef = FirebaseDatabase.instance.ref('users');

      // Fetch the entire users node (without query)
      DataSnapshot usersSnapshot = await usersRef.get();

      // Manually search for the email in the snapshot
      bool emailExists = false;
      Map<dynamic, dynamic> users =
          usersSnapshot.value as Map<dynamic, dynamic>;
      users.forEach((key, value) {
        if (value['email'] != null &&
            value['email'].toString().toLowerCase() == formattedEmail) {
          emailExists = true;
        }
      });

      // Check if email exists
      if (!emailExists) {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar('Email does not exist! 🙂');
        return;
      }

      // Proceed with reset password logic if email exists
      if (formattedEmail.isNotEmpty) {
        await authRepo.resetPassword(email: formattedEmail).then((value) {
          email.clear();
          FullScreenLoader.stopLoading();
          Get.to(() => const EmailSendConfrimation(
                title: 'Email Sent successfully',
                subtitle:
                    'A password reset email has been sent to your email address.',
                description:
                    'You can go to your mail box and check the password reset email. If you see the email open them and click the link which provide you to reset your password. After changing password you will be able to login with new password.',
              ));
        });
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar('Some error occurred: ${e.toString()}');
    }
  }
}
