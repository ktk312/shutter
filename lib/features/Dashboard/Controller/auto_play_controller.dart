import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:shutter_ease/utills/Errors/Error%20handler/error_handler.dart';

class AutoPlayController extends GetxController {
  static AutoPlayController get instance => Get.find();

  final database = FirebaseDatabase.instance;
  Timer? _timer;

  var autoPlayTime = ''.obs;
  var isAutoPlayEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAutoPlayStatus();
    loadAutoPlayTime();
    startAutoPlayScheduler();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // Start the AutoPlay Scheduler
  Future startAutoPlayScheduler() async {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
      // print("Call Function setupAutoPlayShutters");
      await setupAutoPlayShutters();
    });
  }

  // Update Auto-Play Status
  Future<void> updateAutoPlayStatus(bool isEnabled) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDevices = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser?.uid)
          .get();

      if (userDevices.exists) {
        for (var device in userDevices.children) {
          await database.ref('ShutterDevices/${device.key}').update({
            'autoPlay': isEnabled,
          });
          ErrorHandler.showSuccessToast("Auto Play status is updated");
        }
      }
    } catch (e) {
      ErrorHandler.showErrorSnackbar(
          'Failed to update auto play status: ${e.toString()}');
    }
  }

  // Load the Auto-Play Status from the database
  Future<void> loadAutoPlayStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final userShutters = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser.uid)
          .get();

      if (userShutters.exists && userShutters.children.isNotEmpty) {
        final shutter = userShutters.children.first;
        final autoPlayEnabled = shutter.child('autoPlay').value as bool?;
        if (autoPlayEnabled != null) {
          isAutoPlayEnabled.value = autoPlayEnabled;
        }
      }
    }
  }

  // Update Auto-Play Time
  Future<void> updateAutoPlayTime(String time) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      final userDevices = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser?.uid)
          .get();

      if (userDevices.exists) {
        for (var device in userDevices.children) {
          await database.ref('ShutterDevices/${device.key}').update({
            'autoPlayTime': time,
          });
        }

        autoPlayTime.value = time;
        ErrorHandler.showSuccessToast("Auto Play time is updated.");
      }
    } catch (e) {
      ErrorHandler.showErrorSnackbar(
          'Failed to update auto play time: ${e.toString()}');
    }
  }

  // Load the Auto-Play Time
  Future<void> loadAutoPlayTime() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final userShutters = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser.uid)
          .get();

      if (userShutters.exists && userShutters.children.isNotEmpty) {
        final shutter = userShutters.children.first;
        final savedAutoPlayTime =
            shutter.child('autoPlayTime').value as String?;
        if (savedAutoPlayTime != null) {
          autoPlayTime.value = savedAutoPlayTime;
        }
      }
    }
  }

  // Convert the autoPlayTime to 24-hour format
  String? convertTo24HourFormat(String? time) {
    if (time == null || time.isEmpty || time == '00:00') {
      return null;
    }

    try {
      DateFormat inputFormat = DateFormat('h:mm a');
      DateFormat outputFormat = DateFormat('HH:mm');
      DateTime dateTime = inputFormat.parse(time);
      return outputFormat.format(dateTime);
    } catch (e) {
      print("Error converting the autoPlayTime to 24-hour format: $e");
    }

    return null;
  }

  // Set the Shutter State according to User preference
  Future<void> setupAutoPlayShutters() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userShutters = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser.uid)
          .get();

      // Get the current time
      final now = DateTime.now();
      final currentTime =
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
      // print("Current Time: $currentTime");

      // Loop through each shutter to check the Auto Play status and time
      for (var shutter in userShutters.children) {
        final autoPlayEnabled = shutter.child('autoPlay').value as bool;
        final autoPlayTime = shutter.child('autoPlayTime').value as String;

        // Convert autoPlayTime to 24-hour format
        final formattedAutoPlayTime = convertTo24HourFormat(autoPlayTime);

        // print(
        // "Shutter ID: ${shutter.key}, AutoPlay Enabled: $autoPlayEnabled, AutoPlay Time: $formattedAutoPlayTime");

        if (autoPlayEnabled == true && formattedAutoPlayTime == currentTime) {
          // print("Updating shutter ID: ${shutter.key}");

          try {
            await database.ref('ShutterDevices/${shutter.key}').update({
              'shutterIconStatus': true,
              'deviceStatus': true,
            });
            // ErrorHandler.showSuccessToast("Device Status is Updated");
          } catch (e) {
            ErrorHandler.showErrorSnackbar(
                "Error updating device status: ${e.toString()}");
          }
        }
      }
    }
  }
}
