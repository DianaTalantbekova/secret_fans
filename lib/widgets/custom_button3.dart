import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secret_fans/resources/app_styles.dart';

import '../resources/app_colors.dart';

class CustomButton3 extends StatelessWidget {
  const CustomButton3({
    super.key,
    this.asset,
    required this.text,
    this.onTap,
    this.isBlue = true,
    this.hasBorder = false,
  });

  final String? asset;
  final String text;
  final bool isBlue;
  final bool hasBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: isBlue ? AppColors.blue : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: hasBorder ? Border.all(color: AppColors.blue) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              asset != null
                  ? Image.asset(
                      asset!,
                      fit: BoxFit.contain,
                      width: 36.w,
                      height: 36.h,
                      color: AppColors.blueAccent,
                    )
                  : SizedBox(width: 36.w),
              // SizedBox(width: 22.w),
              Center(
                child: Text(
                  text,
                  style: AppStyles.helper4.copyWith(fontSize: 18.r),
                ),
              ),
              SizedBox(width: 36.w),
            ],
          ),
        ),
      ),
    );
  }
}
