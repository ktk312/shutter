import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Dashboard/Controller/schedule_controller.dart';
import 'package:shutter_ease/features/Dashboard/Model/schedule_model.dart';
import 'package:shutter_ease/features/Dashboard/Model/shutter_device_model.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';
import 'package:shutter_ease/utills/constants/colors.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewTimetable extends StatelessWidget {
  final ScheduleController scheduleController;
  final ShutterDeviceModel device;
  final PageController _pageController = PageController();

  ViewTimetable(
      {Key? key, required this.scheduleController, required this.device})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController =
        Get.put(LocalizationController());

    return Obx(
      () {
        if (scheduleController.schedule.isEmpty) {
          return Center(
            child: Text(
              'No schedule is added \nfor "${device.deviceName}".',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins'),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: 390,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      buildFirstTable(localizationController),
                      buildSecondTable(localizationController),
                    ],
                  ),
                ),
              ),
              CustomSizedBox(
                height: 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 2,
                      effect: WormEffect(
                        dotHeight: 7,
                        dotWidth: 40,
                        spacing: 4,
                        activeDotColor: AppColors.textColor,
                        dotColor: Colors.grey,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      if (_pageController.page!.toInt() < 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        _pageController.jumpToPage(0);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildFirstTable(LocalizationController localizationController) {
    return Table(
      border: TableBorder.all(
        color: Colors.grey[300]!,
        width: 1.0,
      ),
      columnWidths: const {
        0: FixedColumnWidth(120),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColors.textColor,
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                localizationController.localizedValues['days']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                localizationController.localizedValues['first_opening']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                localizationController.localizedValues['first_closing']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        ...scheduleController.schedule.map((ScheduleModel item) {
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  item.day,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  item.firstOpeningTime.isEmpty ? "-" : item.firstOpeningTime,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  item.firstClosingTime.isEmpty ? "-" : item.firstClosingTime,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget buildSecondTable(LocalizationController localizationController) {
    return Table(
      border: TableBorder.all(
        color: Colors.grey[300]!,
        width: 1.0,
      ),
      columnWidths: const {
        0: FixedColumnWidth(120),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColors.textColor,
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                localizationController.localizedValues['days']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                localizationController.localizedValues['second_opening']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                localizationController.localizedValues['second_closing']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        ...scheduleController.schedule.map((ScheduleModel item) {
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  item.day,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  item.secondOpeningTime.isEmpty ? "-" : item.secondOpeningTime,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  item.secondClosingTime.isEmpty ? "-" : item.secondClosingTime,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
