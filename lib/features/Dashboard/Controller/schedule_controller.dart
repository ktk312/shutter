import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shutter_ease/features/Dashboard/Model/schedule_model.dart';
import 'package:shutter_ease/features/Dashboard/View/Schedule%20Screens/Widgets/time_table.dart';
import 'package:shutter_ease/utills/Errors/Error%20handler/error_handler.dart';

class ScheduleController extends GetxController {
  final String deviceId;
  final DatabaseReference scheduleRef;
  RxList<ScheduleModel> schedule = <ScheduleModel>[].obs;
  RxBool isSaving = false.obs;

  List<String> days = [
    localizationController.localizedValues['monday']!,
    localizationController.localizedValues['tuesday']!,
    localizationController.localizedValues['wednesday']!,
    localizationController.localizedValues['thursday']!,
    localizationController.localizedValues['friday']!,
    localizationController.localizedValues['saturday']!,
    localizationController.localizedValues['sunday']!,
  ];

  ScheduleController({required this.deviceId})
      : scheduleRef =
            FirebaseDatabase.instance.ref('ShutterDevices/$deviceId/Schedule');

  @override
  void onInit() {
    super.onInit();
    fetchSchedule();
  }

  Future<void> saveSchedule(
    List<TextEditingController> openingControllers,
    List<TextEditingController> closingControllers,
    List<TextEditingController> secondOpeningControllers,
    List<TextEditingController> secondClosingControllers,
  ) async {
    isSaving.value = true;
    try {
      for (int i = 0; i < days.length; i++) {
        final newSchedule = ScheduleModel(
          day: days[i],
          firstOpeningTime: openingControllers[i].text,
          firstClosingTime: closingControllers[i].text,
          secondOpeningTime: secondOpeningControllers[i].text,
          secondClosingTime: secondClosingControllers[i].text,
        );

        await scheduleRef.child(days[i]).update(newSchedule.toJson());
      }
      // Fetch updated schedule after saving to refresh UI state
      await fetchSchedule();
      ErrorHandler.showSuccessToast(localizationController.localizedValues['schedule_updated']!);
    } catch (e) {
      ErrorHandler.showErrorSnackbar(localizationController.localizedValues['error_schedule']!);
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> fetchSchedule() async {
    try {
      scheduleRef.onValue.listen((event) {
        final data = event.snapshot.value;
        if (data != null && data is Map) {
          schedule.clear();
          final scheduleData = Map<String, dynamic>.from(data);

          schedule.addAll(
            scheduleData.entries.map((e) {
              return ScheduleModel.fromJson(Map<String, dynamic>.from(e.value));
            }).toList(),
          );

          schedule.sort((a, b) {
            return days.indexOf(a.day).compareTo(days.indexOf(b.day));
          });
        }
      });
    } catch (e) {
      ErrorHandler.showErrorSnackbar("Error fetching schedule: $e");
    }
  }
}
