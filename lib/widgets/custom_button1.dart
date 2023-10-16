import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class CustomButton1 extends StatelessWidget {
  const CustomButton1({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 254.w,
        height: 71.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: AppColors.lightBlue,
            width: 2.w,
          ),
          color: AppColors.blue,
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.15),
            ),
          ],
        ),
        child: Text(
          text,
          style: AppStyles.helper3,
        ),
      ),
    );
  }
}
