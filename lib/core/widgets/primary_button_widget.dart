import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? textColor;
  final Color? buttonColor;
  final double? width;
  final double? height;
  final double? borderRadious;
  final double? fontSize;
  final VoidCallback? onPressed;

  const PrimaryButtonWidget({
    super.key,
    this.buttonText,
    this.buttonColor,
    this.width,
    this.height,
    this.borderRadious,
    this.textColor,
    this.onPressed, this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? AppColors.primaryOrangeColor,
        fixedSize: Size(width ?? double.maxFinite, height ?? 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadious ?? 8.0),
        ),

      ),
      child: Text(
        buttonText ?? "",
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: fontSize ?? 16.0,
        ),
      ),
    );
  }
}
