import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secret_fans/resources/app_colors.dart';

class AppStyles {
  static final helper1 = TextStyle(
    fontFamily: 'Gardenia',
    fontSize: 36.r,
    color: AppColors.gray,
    fontWeight: FontWeight.w800,
  );
  static final helper2 = TextStyle(
    fontFamily: 'Gardenia',
    fontSize: 20.r,
    color: AppColors.gray,
    fontWeight: FontWeight.w400,
  );
  static final helper3 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28.r,
    color: AppColors.gray,
    fontWeight: FontWeight.w600,
  );
  static final helper4 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20.r,
    color: AppColors.gray,
    fontWeight: FontWeight.w500,
  );
  static final helper5 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18.r,
    color: AppColors.blueAccent,
    fontWeight: FontWeight.w500,
  );
  static final helper6 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.r,
    color: AppColors.grayAccent,
    fontWeight: FontWeight.w400,
  );
  static final helper7 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.r,
    color: AppColors.gray,
    fontWeight: FontWeight.w400,
  );
  static final helper8 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28.r,
    color: AppColors.lightBlue,
    fontWeight: FontWeight.w500,
  );
  static final helper9 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24.r,
    color: AppColors.red,
    fontWeight: FontWeight.w500,
  );

  static final helper10 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14.r,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.w500,
      color: Colors.transparent,
      shadows: const [
        Shadow(
          offset: Offset(0, -2),
          color: AppColors.grayAccent,
        ),
      ],
      decorationStyle: TextDecorationStyle.dashed,
      decorationThickness: 1.5,
      decorationColor: AppColors.grayAccent,
  );
}
