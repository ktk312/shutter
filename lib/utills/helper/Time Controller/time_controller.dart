import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeController extends GetxController {
  // Observables for date and time
  RxString currentTime = ''.obs;
  RxString currentDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Start updating the time every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      updateDateTime();
    });
    // Set initial date and time
    updateDateTime();
  }

  void updateDateTime() {
    final now = DateTime.now();
    currentTime.value = DateFormat('hh:mm:ss a').format(now);
    currentDate.value = DateFormat('dd.MM.yyyy').format(now);
  }
}
