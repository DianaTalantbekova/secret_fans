import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class CustomButton5 extends StatelessWidget {
  const CustomButton5({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),
            topRight: Radius.circular(100),
            bottomRight: Radius.circular(100),
          ),
          border: Border.all(color: AppColors.grayAccent),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(
          left: 6.w,
          right: 12.w,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 4.w),
            Text(
              'Add new',
              style: AppStyles.helper7.copyWith(
                fontSize: 14.r,
                color: AppColors.blueAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
