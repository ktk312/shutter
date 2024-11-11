import 'package:flutter/material.dart';
import 'package:shutter_ease/utills/constants/colors.dart';

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final IconData icon;
  final Function(bool) onChanged;

  const CustomSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.textColor,
      secondary: Icon(icon),
    );
  }
}
