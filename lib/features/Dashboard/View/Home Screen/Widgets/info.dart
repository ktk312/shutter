import 'package:flutter/material.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';
import 'package:shutter_ease/utills/constants/sizeBox.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final mq = CustomMediaQuery(context);
    return Row(
      children: [
        Container(
          height: mq.getHeight(0.05),
          width: mq.getWidth(0.009),
          decoration: const BoxDecoration(
            color: Color(0xFFFFD481),
          ),
        ),
        const CustomSizedBox(
          width: 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'PoppinsRegular')),
            const CustomSizedBox(
              height: 0.002,
            ),
            Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontFamily: 'PoppinsRegular')),
          ],
        )
      ],
    );
  }
}
