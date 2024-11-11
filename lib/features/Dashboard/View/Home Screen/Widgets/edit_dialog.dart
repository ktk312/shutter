import 'package:flutter/material.dart';
import 'package:shutter_ease/utills/constants/colors.dart';

void showEditDialog(BuildContext context, String? deviceName) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit your shutter",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'PoppinsRegular',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              deviceName ?? "Nill", // Display device name
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor,
                fontFamily: 'PoppinsBold',
              ),
            ),
            const SizedBox(height: 20),
            // Your switch rows go here
            // ...
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(fontFamily: 'PoppinsRegular'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Update",
              style: TextStyle(fontFamily: 'PoppinsRegular'),
            ),
          ),
        ],
      );
    },
  );
}
