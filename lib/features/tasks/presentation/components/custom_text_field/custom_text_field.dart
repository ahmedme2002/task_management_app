import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app/core/utilities/configs/app_typography.dart';
import 'package:task_management_app/core/utilities/configs/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final bool readOnly;
  final bool obscure;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    this.onFieldSubmitted,
    this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.contentPadding,
    this.enabledBorder,
    this.focusedBorder,
    this.readOnly = false,
    this.obscure = false,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      controller: widget.controller,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        enabledBorder: widget.enabledBorder ??
            UnderlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: AllColors.grey),
            ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: font_16Size,
                color: AllColors.grey,
              ),
            ),
        focusedBorder: widget.focusedBorder ??
            UnderlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: AllColors.blue),
            ),
      ),
    );
  }
}
