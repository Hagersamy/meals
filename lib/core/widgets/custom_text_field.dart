import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/app_colors.dart';

class CustomEditText extends StatelessWidget {
  final String? hintText;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomEditText({
    super.key,
    this.hintText,
    this.width,
    this.height,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        borderSide: BorderSide(color: color, width: 1),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        style: TextStyle(fontSize: 15.sp, color: AppColors.blackColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15.sp, color: AppColors.grayColor),
          filled: true,
          fillColor: fillColor ?? const Color(0xFFF7F8F9),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: _border(borderColor ?? const Color(0xFFE8ECF4)),
          focusedBorder: _border(AppColors.primaryOrangeColor),
          errorBorder: _border(Colors.red),
          focusedErrorBorder: _border(Colors.red),
        ),
      ),
    );
  }
}
