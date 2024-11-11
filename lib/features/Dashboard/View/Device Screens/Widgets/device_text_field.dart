import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomdeviceInputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomdeviceInputField({
    super.key,
    required this.label,
    required this.icon,
    required this.validator,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
            color: const Color.fromARGB(255, 94, 94, 94).withOpacity(0.9)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(icon),
      ),
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }
}
