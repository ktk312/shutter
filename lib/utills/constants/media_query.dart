import 'package:flutter/material.dart';

class CustomMediaQuery {
  final BuildContext context;

  CustomMediaQuery(this.context);

  double getWidth(double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  double getHeight(double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }
}
