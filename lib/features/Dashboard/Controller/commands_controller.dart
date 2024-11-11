import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shutter_ease/features/Dashboard/View/Home%20Screen/home_screen.dart';
import 'package:shutter_ease/utills/Errors/Error%20handler/error_handler.dart';
import 'package:shutter_ease/utills/helper/Popups/screen_loader.dart';

class CommandsController extends GetxController {
  static CommandsController get instance => Get.find();

  final database = FirebaseDatabase.instance;

  // Open All Shutters
  Future<void> openAll() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Opening all shutters...',
        'assets/files/signupAnimtion.json',
      );

      final currentUser = FirebaseAuth.instance.currentUser;

      // Fetch devices belonging to the current user
      final userDevices = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser?.uid)
          .get();

      if (userDevices.exists) {
        // Loop through all devices and update shutter status to 'open'
        for (var device in userDevices.children) {
          await database.ref('ShutterDevices/${device.key}').update({
            'shutterIconStatus': true,
          });
        }

        FullScreenLoader.stopLoading();
        ErrorHandler.showSuccessSnackkbar(
          'Success!',
          'All shutters have been successfully opened.',
        );
        Get.to(HomeScreen());
      } else {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar(
          'No shutters found for your account.',
        );
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
        'Failed to open shutters: ${e.toString()}',
      );
    }
  }

  // Close All Shutters
  Future<void> closeAll() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Closing all shutters...',
        'assets/files/signupAnimtion.json',
      );

      final currentUser = FirebaseAuth.instance.currentUser;

      // Fetch devices belonging to the current user
      final userDevices = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser?.uid)
          .get();

      if (userDevices.exists) {
        // Loop through all devices and update shutter status to 'closed'
        for (var device in userDevices.children) {
          await database.ref('ShutterDevices/${device.key}').update({
            'shutterIconStatus': false,
          });
        }

        FullScreenLoader.stopLoading();
        ErrorHandler.showSuccessSnackkbar(
          'Success!',
          'All shutters have been successfully closed.',
        );
        Get.to(HomeScreen());
      } else {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar(
          'No shutters found for your account.',
        );
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
        'Failed to close shutters: ${e.toString()}',
      );
    }
  }

  // Activate All Devices
  Future<void> playAll() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Activating all devices...',
        'assets/files/signupAnimtion.json',
      );

      final currentUser = FirebaseAuth.instance.currentUser;

      // Fetch devices belonging to the current user
      final userDevices = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser?.uid)
          .get();

      if (userDevices.exists) {
        // Loop through all devices and set their status to 'active'
        for (var device in userDevices.children) {
          await database.ref('ShutterDevices/${device.key}').update({
            'deviceStatus': true,
          });
        }

        FullScreenLoader.stopLoading();
        ErrorHandler.showSuccessSnackkbar(
          'Success!',
          'All devices have been activated.',
        );
        Get.to(HomeScreen());
      } else {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar(
          'No devices found for your account.',
        );
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
        'Failed to activate devices: ${e.toString()}',
      );
    }
  }

  // Deactivate All Devices
  Future<void> stopAll() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Deactivating all devices...',
        'assets/files/signupAnimtion.json',
      );

      final currentUser = FirebaseAuth.instance.currentUser;

      // Fetch devices belonging to the current user
      final userDevices = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser?.uid)
          .get();

      if (userDevices.exists) {
        // Loop through all devices and set their status to 'inactive'
        for (var device in userDevices.children) {
          await database.ref('ShutterDevices/${device.key}').update({
            'deviceStatus': false,
          });
        }

        FullScreenLoader.stopLoading();
        ErrorHandler.showSuccessSnackkbar(
          'Success!',
          'All devices have been deactivated.',
        );
        Get.to(HomeScreen());
      } else {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar(
          'No devices found for your account.',
        );
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
        'Failed to deactivate devices: ${e.toString()}',
      );
    }
  }

  // Function to open all shutters and stop their status (make inactive)
  Future<void> openAllAndStop() async {
    try {
      // Show loading dialog with a message
      FullScreenLoader.openLoadingDialog(
        'Opening all shutters and stopping devices...',
        'assets/files/signupAnimtion.json',
      );

      final currentUser = FirebaseAuth.instance.currentUser;

      // Retrieve shutters associated with the current user
      final userDevices = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser?.uid)
          .get();

      if (userDevices.exists) {
        // Update each device to open the shutters and deactivate the devices
        for (var device in userDevices.children) {
          await database.ref('ShutterDevices/${device.key}').update({
            'shutterIconStatus': true,
            'deviceStatus': false,
          });
        }

        // Stop loading and show success message
        FullScreenLoader.stopLoading();
        ErrorHandler.showSuccessSnackkbar(
          'Success!',
          'All shutters have been opened and devices deactivated.',
        );
        Get.to(HomeScreen());
      } else {
        // Stop loading and show error if no shutters found
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar(
          'No shutters associated with your account were found.',
        );
      }
    } catch (e) {
      // Stop loading and show error if operation fails
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
        'Failed to open shutters and stop devices: ${e.toString()}',
      );
    }
  }

  // Function to close all shutters and stop their status (make inactive)
  Future<void> closeAllAndStop() async {
    try {
      // Show loading dialog with a message
      FullScreenLoader.openLoadingDialog(
        'Closing all shutters and stopping devices...',
        'assets/files/signupAnimtion.json',
      );

      final currentUser = FirebaseAuth.instance.currentUser;

      // Retrieve shutters associated with the current user
      final userDevices = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser?.uid)
          .get();

      if (userDevices.exists) {
        // Update each device to close the shutters and deactivate the devices
        for (var device in userDevices.children) {
          await database.ref('ShutterDevices/${device.key}').update({
            'shutterIconStatus': false,
            'deviceStatus': false,
          });
        }

        // Stop loading and show success message
        FullScreenLoader.stopLoading();
        ErrorHandler.showSuccessSnackkbar(
          'Success!',
          'All shutters have been closed and devices deactivated.',
        );
        Get.to(HomeScreen());
      } else {
        // Stop loading and show error if no shutters found
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar(
          'No shutters associated with your account were found.',
        );
      }
    } catch (e) {
      // Stop loading and show error if operation fails
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
        'Failed to close shutters and stop devices: ${e.toString()}',
      );
    }
  }

  // Enable All Device Schedules (Calendar ON)
  Future<void> calenderON() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Enabling schedules for all devices...',
        'assets/files/signupAnimtion.json',
      );

      final currentUser = FirebaseAuth.instance.currentUser;

      // Fetch devices belonging to the current user
      final userDevices = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser?.uid)
          .get();

      if (userDevices.exists) {
        // Loop through all devices and enable the calendar schedule
        for (var device in userDevices.children) {
          await database.ref('ShutterDevices/${device.key}').update({
            'calenderStatus': true,
          });
        }

        FullScreenLoader.stopLoading();
        ErrorHandler.showSuccessSnackkbar(
          'Success!',
          'Schedules have been activated for all devices.',
        );
        Get.to(HomeScreen());
      } else {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar(
          'No devices found for your account.',
        );
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
        'Failed to activate schedules: ${e.toString()}',
      );
    }
  }

  // Disable All Device Schedules (Calendar OFF)
  Future<void> calenderOFF() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Disabling schedules for all devices...',
        'assets/files/signupAnimtion.json',
      );

      final currentUser = FirebaseAuth.instance.currentUser;

      // Fetch devices belonging to the current user
      final userDevices = await database
          .ref('ShutterDevices')
          .orderByChild('userId')
          .equalTo(currentUser?.uid)
          .get();

      if (userDevices.exists) {
        // Loop through all devices and disable the calendar schedule
        for (var device in userDevices.children) {
          await database.ref('ShutterDevices/${device.key}').update({
            'calenderStatus': false,
          });
        }

        FullScreenLoader.stopLoading();
        ErrorHandler.showSuccessSnackkbar(
          'Success!',
          'Schedules have been deactivated for all devices.',
        );
        Get.to(HomeScreen());
      } else {
        FullScreenLoader.stopLoading();
        ErrorHandler.showErrorSnackbar(
          'No devices found for your account.',
        );
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
        'Failed to deactivate schedules: ${e.toString()}',
      );
    }
  }
}
