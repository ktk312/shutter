import 'package:flutter/material.dart';
import 'package:shutter_ease/utills/constants/media_query.dart';

class CustomSizedBox extends StatelessWidget {
  final double height;
  final double width;

  const CustomSizedBox({
    super.key,
    this.height = 0.0,
    this.width = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = CustomMediaQuery(context);
    return SizedBox(
      height: mediaQuery.getHeight(height),
      width: mediaQuery.getWidth(width),
    );
  }
}
