import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ErrorHandler {
  // Snackbar for temporary errors
  static void showErrorSnackbar(String message) {
    Get.snackbar(
      "Error404",
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  static void showSuccessSnackkbar(String? title, String message) {
    Get.snackbar(
      title ?? "Congratulation",
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      // backgroundColor: const Color.fromARGB(255, 172, 0, 0),
      colorText: Colors.black,
      duration: const Duration(seconds: 3),
    );
  }

  // Dialog for blocking errors
  static void showErrorDialog(String? title, String message) {
    Get.dialog(
      AlertDialog(
        title: Text(
          title!,
        ),
        content: Text(
          message,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Toast notification for quick errors
  static void showErrorToast(
    String message,
  ) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Toast notification for quick sucesss
  static void showSuccessToast(
    String message,
  ) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Error screen for critical errors
  static Widget errorScreen(String message, VoidCallback onRetry) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 50),
            const SizedBox(height: 20),
            Text('Oops! $message', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
