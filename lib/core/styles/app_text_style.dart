import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle get onBoardingTextStyle => GoogleFonts.inter(fontSize: 32.sp,color: Colors.white);
  static TextStyle get onBoardingDescriptionTextStyle => GoogleFonts.inter(fontSize: 16.sp,color: Colors.white);
  static TextStyle get black16Medium => GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500,color: Colors.black);
  static TextStyle get grey14Regular => GoogleFonts.inter(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Colors.grey);
  static TextStyle get homeWelcomeTextStyle => GoogleFonts.inter(fontSize: 16.sp,color: Colors.black87);
  static TextStyle get homeTitleTextStyle => GoogleFonts.inter(fontSize: 28.sp,fontWeight: FontWeight.bold,color: Colors.black87);
}
