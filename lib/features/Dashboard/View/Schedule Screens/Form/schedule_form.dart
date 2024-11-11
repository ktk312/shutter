import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Dashboard/Controller/schedule_controller.dart';
import 'package:shutter_ease/features/Dashboard/Model/shutter_device_model.dart';
import 'package:shutter_ease/features/Dashboard/View/Schedule%20Screens/Widgets/time_table.dart';
import 'package:shutter_ease/utills/constants/colors.dart';

class ScheduleForm extends StatefulWidget {
  final ShutterDeviceModel device;
  const ScheduleForm({super.key, required this.device});

  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm>
    with SingleTickerProviderStateMixin {
  late final ScheduleController scheduleController;
  late TabController _tabController;

  List<TextEditingController> openingControllers = [];
  List<TextEditingController> closingControllers = [];
  List<TextEditingController> secondOpeningControllers = [];
  List<TextEditingController> secondClosingControllers = [];

  @override
  void initState() {
    super.initState();
    scheduleController = Get.put(
        ScheduleController(deviceId: widget.device.deviceId.toString()));
    _tabController = TabController(length: 2, vsync: this);
    _initializeControllers();
    scheduleController.fetchSchedule();
  }

  void _initializeControllers() {
    for (int i = 0; i < 7; i++) {
      openingControllers.add(TextEditingController());
      closingControllers.add(TextEditingController());
      secondOpeningControllers.add(TextEditingController());
      secondClosingControllers.add(TextEditingController());
    }

    // Update controllers with existing schedule data
    scheduleController.schedule.listen((scheduleList) {
      for (int i = 0; i < scheduleList.length; i++) {
        final scheduleItem = scheduleList[i];
        openingControllers[i].text = scheduleItem.firstOpeningTime;
        closingControllers[i].text = scheduleItem.firstClosingTime;
        secondOpeningControllers[i].text = scheduleItem.secondOpeningTime;
        secondClosingControllers[i].text = scheduleItem.secondClosingTime;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.textColor,
        title: Text(localizationController.localizedValues['add_schedule']!,
          style: TextStyle(
            fontFamily: 'PoppinsRegular',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.6),
          indicatorColor: Colors.transparent,
          labelStyle: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          tabs: [
            Tab(text: localizationController.localizedValues['first_par']),
            Tab(text: localizationController.localizedValues['second_par']),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildScheduleTable(openingControllers, closingControllers),
                  buildScheduleTable(
                      secondOpeningControllers, secondClosingControllers),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: InkWell(
                onTap: () async {
                  await scheduleController.saveSchedule(
                    openingControllers,
                    closingControllers,
                    secondOpeningControllers,
                    secondClosingControllers,
                  );
                },
                child: Obx(() => Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppColors.textColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: scheduleController.isSaving.value
                            ? Center(
                                child: const CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : Text(localizationController.localizedValues['save_calendar']!,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                      ),
                    )),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildScheduleTable(
    List<TextEditingController> openingCtrls,
    List<TextEditingController> closingCtrls,
  ) {
    return SingleChildScrollView(
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(100),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
        },
        children: [
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(localizationController.localizedValues['days']!,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(localizationController.localizedValues['opening']!,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(localizationController.localizedValues['closing']!,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              ),
            ],
          ),
          ...List.generate(7, (index) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    scheduleController.days[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: openingCtrls[index]
                      ..text = openingCtrls[index].text.isEmpty
                          ? '-'
                          : openingCtrls[index].text,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    onTap: () {
                      if (openingCtrls[index].text == '-') {
                        openingCtrls[index].clear();
                      }
                    },
                    onFieldSubmitted: (value) {
                      if (value.isEmpty) {
                        openingCtrls[index].text = '-';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: closingCtrls[index]
                      ..text = closingCtrls[index].text.isEmpty
                          ? '-'
                          : closingCtrls[index].text,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    onTap: () {
                      if (closingCtrls[index].text == '-') {
                        closingCtrls[index].clear();
                      }
                    },
                    onFieldSubmitted: (value) {
                      if (value.isEmpty) {
                        closingCtrls[index].text = '-';
                      }
                    },
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
