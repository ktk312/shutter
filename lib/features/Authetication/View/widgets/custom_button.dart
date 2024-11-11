import 'package:flutter/material.dart';
import 'package:shutter_ease/utills/constants/colors.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';

class CustomButton extends StatelessWidget {
  final String? btNName;
  final VoidCallback ontap;
  const CustomButton({
    super.key,
    required this.mq,
    this.btNName,
    required this.ontap,
  });

  final CustomMediaQuery mq;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: mq.getHeight(0.065),
        decoration: BoxDecoration(
            color: AppColors.textColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            btNName ?? "Sign in",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: 'PoppinsRegular'),
          ),
        ),
      ),
    );
  }
}
