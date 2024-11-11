import 'package:flutter/material.dart';
import 'package:shutter_ease/utills/constants/colors.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final int? maxLines;
  final VoidCallback? suffixPressed;
  final String? Function(String?)? validator;
  final int? maxWords;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final VoidCallback? ontap;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.text,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.suffixPressed,
    this.validator,
    this.maxWords,
    this.controller,
    this.readOnly = false,
    this.ontap,
    this.keyboardType, this.textInputAction,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onTap: widget.ontap,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      maxLines: widget.maxLines ?? 1,
      maxLength: widget.maxWords,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: (value) {
        if (widget.textInputAction == TextInputAction.next) {
          FocusScope.of(context).nextFocus();
        }
      },
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        hintText: widget.text,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.apply(
              color: const Color(0xff626262),
              overflow: TextOverflow.ellipsis,
            ),
        filled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.textColor,
            width: 2,
          ),
        ),
      ),
      style: Theme.of(context).textTheme.bodyLarge!.apply(
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
    );
  }
}
