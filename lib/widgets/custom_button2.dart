import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class CustomButton2 extends StatelessWidget {
  const CustomButton2({
    super.key,
    this.onTap,
    required this.text,
    this.selected = false,
  });

  final VoidCallback? onTap;
  final String text;
  final bool selected;

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
          color: selected ? AppColors.blueAccent : Colors.white,
        ),
        padding: EdgeInsets.only(
          left: 6.w,
          right: 12.w,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/png/icons/tag.png',
              fit: BoxFit.contain,
              width: 24.w,
              height: 24.h,
              color: selected ? AppColors.lightestBlue : AppColors.blueAccent,
            ),
            SizedBox(width: 4.w),
            Text(
              text,
              style: AppStyles.helper7.copyWith(fontSize: 14.r),
            )
          ],
        ),
      ),
    );
  }
}
