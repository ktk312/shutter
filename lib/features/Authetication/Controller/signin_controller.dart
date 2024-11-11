import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/data/repository/authentication_repository.dart';
import 'package:shutter_ease/features/Dashboard/View/Home%20Screen/home_screen.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/Errors/Error%20handler/error_handler.dart';
import 'package:shutter_ease/utills/helper/Popups/screen_loader.dart';

class SigninController extends GetxController {
  static SigninController get instance => Get.find();

  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();

  final authRepo = Get.put(AuthenticationRepository());

  final email = TextEditingController();
  final password = TextEditingController();

  final LocalizationController localizationController = Get.find();

  Future<void> userSignin() async {
    try {
      FullScreenLoader.openLoadingDialog(
        localizationController.localizedValues['loading_message']!,
        'assets/files/signupAnimtion.json',
      );

      if (!signinFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      DatabaseReference usersRef = FirebaseDatabase.instance.ref('users');

      DataSnapshot usersSnapshot = await usersRef.get();

      bool emailExists = false;
      bool passwordMatches = false;

      Map<dynamic, dynamic> users =
          usersSnapshot.value as Map<dynamic, dynamic>;

      users.forEach((key, value) {
        if (value['email'] != null &&
            value['email'].toString().toLowerCase() ==
                email.text.trim().toLowerCase()) {
          emailExists = true;
          if (value['password'] != null &&
              value['password'].toString() == password.text.trim()) {
            passwordMatches = true;
          }
        }
      });

      if (!emailExists && !passwordMatches) {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar('User not signed up! 🙁');
        return;
      }

      if (emailExists && !passwordMatches) {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar(
            localizationController.localizedValues['incorrect_password']!);
        return;
      }

      if (!emailExists) {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar('Email does not exist! 🙂');
        return;
      }

      String? errorMessage = await authRepo.login(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (errorMessage != null) {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar(errorMessage);
        return;
      }

      email.clear();
      password.clear();

      FullScreenLoader.stopLoading();
      ErrorHandler.showSuccessSnackkbar(
          'Success', localizationController.localizedValues['login_success']!);
      Get.to(() => const HomeScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
        'An unexpected error occurred: ${e.toString()}',
      );
    }
  }
}
