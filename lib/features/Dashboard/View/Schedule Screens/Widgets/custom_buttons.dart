import 'package:flutter/material.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';

class CustomDetailButtons extends StatelessWidget {
  final Color color;
  final String text;
  final CustomMediaQuery mq;
  final VoidCallback ontap;

  const CustomDetailButtons({
    super.key,
    required this.mq,
    required this.color,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: mq.getWidth(0.45),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PoppinsRegular'),
            ),
          ),
        ),
      ),
    );
  }
}
