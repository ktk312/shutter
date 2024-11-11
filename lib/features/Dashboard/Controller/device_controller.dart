import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shutter_ease/data/repository/user_repository.dart';
import 'package:shutter_ease/features/Dashboard/Model/shutter_device_model.dart';
import 'package:shutter_ease/features/Dashboard/View/Home%20Screen/home_screen.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/Errors/Error%20handler/error_handler.dart';
import 'package:shutter_ease/utills/helper/Popups/screen_loader.dart';

class DeviceController extends GetxController {
  static DeviceController get instance => Get.find();

  final database = FirebaseDatabase.instance;
  final LocalizationController localizationController =
      Get.put(LocalizationController());

  GlobalKey<FormState> deviceFormKey = GlobalKey<FormState>();

  // Observable list to hold shutter devices
  var devices = <ShutterDeviceModel>[].obs;

  final macAddressController = TextEditingController();
  final deviceNameController = TextEditingController();
  final PanelOperationPercentage = TextEditingController();
  final batteryPercentage = TextEditingController();
  final deviceStatus = false.obs;
  final fCrep = false.obs;
  final fAuto = false.obs;
  final aParz = false.obs;
  final calenderStatus = false.obs;
  final RxString shutterType = ''.obs;
  final RxString priority = ''.obs;
  final RxInt numberOfMotors = 1.obs;

  // Define observable lists to hold TextEditingControllers
  var openingControllers = <TextEditingController>[].obs;
  var closingControllers = <TextEditingController>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenForDeviceChanges();
  }

  // Function to listen for real-time device changes
  void listenForDeviceChanges() {
    database.ref('ShutterDevices').onValue.listen((event) {
      final snapshot = event.snapshot;
      devices.clear();

      if (snapshot.exists) {
        for (var deviceSnapshot in snapshot.children) {
          final deviceData = deviceSnapshot.value as Map<dynamic, dynamic>;

          // Check if the userId matches
          if (deviceData['userId'] == FirebaseAuth.instance.currentUser?.uid) {
            devices.add(ShutterDeviceModel.fromJson(deviceData));
          }
        }
      } else {
        print(
            "No devices found linked to your account. Please add a device to continue.");
        // ErrorHandler.showErrorSnackbar(
        //   'No devices found linked to your account. Please add a device to continue.',
        // );
      }
    });
  }

  // Save the new Device
  Future<void> saveShutterDevice() async {
    try {
      FullScreenLoader.openLoadingDialog(
        'Saving Device Information....',
        'assets/files/signupAnimtion.json',
      );

      if (!deviceFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      final userRepo = Get.put(UserRepository());
      final userData = userRepo.userData;

      // Fetch the current number of shutters to generate a new ID
      // final deviceCountSnapshot = await database.ref('ShutterDevices').get();
      // int newDeviceId = (deviceCountSnapshot.children.length + 1);
      final newDeviceId = macAddressController.text.trim();

      ShutterDeviceModel device = ShutterDeviceModel(
        userId: userData['id'],
        userName: userData['name'],
        userEmail: userData['email'],
        deviceId: newDeviceId,
        deviceMac: macAddressController.text.trim(),
        deviceName: deviceNameController.text.trim(),
        devicePanelOperationPercentage: PanelOperationPercentage.text.trim(),
        wifiPercentage: '',
        batteryPercentage: batteryPercentage.text.trim(),
        deviceStatus: deviceStatus.value,
        fCrep: fCrep.value,
        fAuto: fAuto.value,
        aParz: aParz.value,
        calenderStatus: calenderStatus.value,
        shutterIconStatus: false,
        timestamp: DateTime.now(),
        hasDeviceSchedule: false,
        shutterType: shutterType.value,
        priority: priority.value,
        numberOfMotors: numberOfMotors.value,
        autoPlay: false,
        autoPlayTime: '',
      );

      // Save to Realtime Database with the new incrementing device ID
      await database.ref('ShutterDevices/$newDeviceId').set(device.toJson());

      FullScreenLoader.stopLoading();
      listenForDeviceChanges();

      ErrorHandler.showSuccessSnackkbar(
        'Success',
        'Device added successfully! You can now manage your shutters.',
      );

      Get.to(() => const HomeScreen());

      // Clear all form controllers after saving
      macAddressController.clear();
      deviceNameController.clear();
      deviceStatus.value = false;
      fCrep.value = false;
      fAuto.value = false;
      aParz.value = false;
      calenderStatus.value = false;
      shutterType.value = '';
      priority.value = '';
      numberOfMotors.value = 1;
    } catch (e) {
      FullScreenLoader.stopLoading();
      ErrorHandler.showErrorSnackbar(
        'Unable to save the device. Please check your connection and try again.',
      );
    }
  }

  // Delete the Device
  Future<void> deleteShutterDevice(
      BuildContext context, String deviceID) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => AlertDialog(
            title: Text(
              localizationController.localizedValues['confirm_deletion_title']!,
              style: TextStyle(fontSize: 18),
            ),
            content: Text(localizationController
                .localizedValues['confirm_deletion_message']!),
            actions: <Widget>[
              TextButton(
                child: Text(localizationController.localizedValues['cancel']!),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(localizationController.localizedValues['delete']!),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
    );

    if (shouldDelete == true) {
      try {
        DatabaseReference deviceRef = database.ref('ShutterDevices/$deviceID');

        await deviceRef.remove();
        listenForDeviceChanges();
        ErrorHandler.showSuccessSnackkbar(
          'Success',
          'Device deleted successfully!',
        );

        Get.to(() => const HomeScreen());
      } catch (e) {
        ErrorHandler.showErrorSnackbar(
          'Unable to delete the device. Please check your connection and try again.',
        );
      }
    }
  }

  // Fetch devices for the current user
  Future<void> fetchDevices() async {
    try {
      // Clear the existing devices list
      devices.clear();

      // Fetch devices where userId matches the current user's ID
      final snapshot = await database.ref('ShutterDevices').get();

      if (snapshot.exists) {
        for (var deviceSnapshot in snapshot.children) {
          final deviceData = deviceSnapshot.value as Map<dynamic, dynamic>;

          // Check if the userId matches
          if (deviceData['userId'] == FirebaseAuth.instance.currentUser?.uid) {
            listenForDeviceChanges();
            devices.add(ShutterDeviceModel.fromJson(deviceData));
          }
        }
      } else {
        print("No devices found associated with your account.");
        // ErrorHandler.showErrorSnackbar(
        //   'No devices found associated with your account.',
        // );
      }
    } catch (e) {
      ErrorHandler.showErrorSnackbar(
        'Failed to load devices. Please try again.',
      );
    }
  }

  // Method to update device data
  Future<void> updateDevice(String deviceId, bool newStatus, bool newFcrp,
      bool newFauto, bool newaParz, bool newcalenderStatus) async {
    try {
      await database.ref('ShutterDevices/$deviceId').update({
        'deviceStatus': newStatus,
        'fCrep': newFcrp,
        'fAuto': newFauto,
        'aParz': newaParz,
        'calenderStatus': newcalenderStatus,
      });
      listenForDeviceChanges();
      ErrorHandler.showSuccessToast("Device status updated successfully!");
    } catch (e) {
      Get.snackbar('Error', 'Unable to update device. Please try again.');
    }
  }

  // Toggle and Update the Shutter Icon Status
  Future<void> toggleDeviceStatus(String deviceKey) async {
    print('Received Device Key: $deviceKey');
    final deviceSnapshot =
        await database.ref('ShutterDevices/$deviceKey').once();

    if (deviceSnapshot.snapshot.exists) {
      final deviceData =
          deviceSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (deviceData != null) {
        bool currentIconStatus = deviceData['shutterIconStatus'] ?? false;
        print('Current Shutter Icon Status: $currentIconStatus');

        // Toggle the shutter icon status
        await database.ref('ShutterDevices/$deviceKey').update({
          'shutterIconStatus': !currentIconStatus,
        }).then((_) {
          print('Shutter icon status successfully updated.');
          ErrorHandler.showSuccessToast(
            'Shutter icon status has been updated.',
          );
        }).catchError((error) {
          print('Error updating shutter icon status: $error');
          ErrorHandler.showErrorSnackbar(
            'Failed to update shutter icon status. Please try again.',
          );
        });
      } else {
        ErrorHandler.showErrorSnackbar('Device data is unavailable.');
      }
    } else {
      ErrorHandler.showErrorSnackbar('No device found with the given key.');
    }
  }

  // Update the device data with new values
  Future<void> updateDeviceNewData(
    String deviceId,
    int? sleepTime,
    int? openingEffort1,
    int? openingEffort2,
    int? openingEffort3,
    int? closingEffort1,
    int? closingEffort2,
    int? closingEffort3,
    String? deviceNames,
  ) async {
    try {
      await database.ref('ShutterDevices/$deviceId').update({
        'sleepTime': sleepTime,
        'openingEffort1': openingEffort1,
        'openingEffort2': openingEffort2,
        'openingEffort3': openingEffort3,
        'closingEffort1': closingEffort1,
        'closingEffort2': closingEffort2,
        'closingEffort3': closingEffort3,
        'deviceName': deviceNames,
      });
      listenForDeviceChanges();
      ErrorHandler.showSuccessToast(
        'Device updated successfully!',
      );
    } catch (e) {
      ErrorHandler.showErrorSnackbar(
        'Unable to update the device. Please try again.',
      );
    }
  }

  // Reset Alarm function to set a specific value
  Future<void> resetAlarm(String deviceId) async {
    try {
      await database.ref('ShutterDevices/$deviceId').update({
        'alarmResetButton': 1,
      });
      listenForDeviceChanges();
      ErrorHandler.showSuccessToast(
        'Alarm has been reset successfully!',
      );
    } catch (e) {
      ErrorHandler.showErrorSnackbar(
        'Failed to reset the alarm. Please try again.',
      );
    }
  }
}
