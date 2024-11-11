import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/localization/Controller/localization_controller.dart';

final openingControllers =
    List.generate(7, (index) => TextEditingController(text: "12:00"));
final closingControllers =
    List.generate(7, (index) => TextEditingController(text: "24:00"));

final LocalizationController localizationController = Get.find();

List<TableRow> buildDayRows() {
  final days = [
    localizationController.localizedValues['monday']!,
    localizationController.localizedValues['tuesday']!,
    localizationController.localizedValues['wednesday']!,
    localizationController.localizedValues['thursday']!,
    localizationController.localizedValues['friday']!,
    localizationController.localizedValues['saturday']!,
    localizationController.localizedValues['sunday']!
  ];

  return List.generate(7, (index) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            days[index],
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: 'PoppinsRegular'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: openingControllers[index],
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.all(8.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: closingControllers[index],
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.all(8.0),
            ),
          ),
        ),
      ],
    );
  });
}

// Build text fields for time input
Widget buildTimeField(String hour, String minute) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 40,
        child: TextFormField(
          initialValue: hour,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.all(8.0),
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          ":",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'PoppinsRegular'),
        ),
      ),
      SizedBox(
        width: 40,
        child: TextFormField(
          initialValue: minute,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.all(8.0),
          ),
        ),
      ),
    ],
  );
}
