import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/data/repository/authentication_repository.dart';
import 'package:shutter_ease/features/Authetication/View/Signin/signin_screen.dart';
import 'package:shutter_ease/utills/Errors/Error%20handler/error_handler.dart';
import 'package:shutter_ease/utills/helper/Popups/screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final authRepo = Get.put(AuthenticationRepository());

  // Variables
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  // User Signup
  Future<void> userSignUp() async {
    try {
      // Start loading animation
      FullScreenLoader.openLoadingDialog(
        'We are processing your information',
        'assets/files/signupAnimtion.json',
      );

      // // Step 1: Check internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   ErrorHandler.showErrorSnackbar('No Internet connection');
      //   return; // Early exit
      // }

      // Step 2: Form validation
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Step 3: Create user account
      await authRepo.createUserAccount(
        name.text.toString(),
        email.text.trim(),
        password.text.trim(),
        confirmPassword.text.trim(),
      );

      name.clear();
      email.clear();
      password.clear();
      confirmPassword.clear();

      FullScreenLoader.stopLoading();

      // Show success message
      ErrorHandler.showSuccessSnackkbar(
          "Success", "User Account is created successfully");

      // Navigate to sign-in screen
      Get.to(() => const SigninScreen());
    } catch (e) {
      // Catch any other errors
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
          'An unexpected error occurred: ${e.toString()}');
    }
  }
}
