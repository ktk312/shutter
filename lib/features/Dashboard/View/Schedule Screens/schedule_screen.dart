import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shutter_ease/features/Dashboard/Controller/schedule_controller.dart';
import 'package:shutter_ease/features/Dashboard/Model/shutter_device_model.dart';
import 'package:shutter_ease/features/Dashboard/View/Schedule%20Screens/Form/schedule_form.dart';
import 'package:shutter_ease/features/Dashboard/View/Schedule%20Screens/Widgets/view_time_table.dart';
import 'package:shutter_ease/utills/constants/colors.dart';

class ScheduleScreen extends StatefulWidget {
  final ShutterDeviceModel device;

  const ScheduleScreen({super.key, required this.device});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ScheduleController scheduleController;

  @override
  void initState() {
    super.initState();
    scheduleController = Get.put(
        ScheduleController(deviceId: widget.device.deviceId.toString()));
    scheduleController.fetchSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.textColor,
        title: Text(
          widget.device.deviceName ?? "",
          style: TextStyle(
            fontFamily: 'PoppinsRegular',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ViewTimetable(
        scheduleController: scheduleController,
        device: widget.device,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.textColor,
        onPressed: () {
          Get.to(() => ScheduleForm(device: widget.device));
        },
        child: Icon(
          Iconsax.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
