import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 254.w,
      height: 56.h,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              alignment: Alignment.center,
              height: 48.h,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grayAccent),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                style: AppStyles.helper7.copyWith(fontSize: 18.r),
                cursorColor: AppColors.gray,
                decoration: const InputDecoration.collapsed(hintText: ''),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 14.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              color: Colors.white,
              child: Text(
                title,
                style: AppStyles.helper5.copyWith(fontSize: 12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
