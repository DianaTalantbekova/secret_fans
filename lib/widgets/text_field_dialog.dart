import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class TextFieldDialog extends StatelessWidget {
  const TextFieldDialog({
    super.key,
    required this.text,
    this.onCancelTap,
    this.onOkTap,
  });

  final String text;
  final VoidCallback? onCancelTap;
  final VoidCallback? onOkTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 270.h),
          width: 302.w,
          height: 164.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grayAccent),
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 2),
                blurRadius: 2,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.15),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text,
                    style: AppStyles.helper4.copyWith(fontSize: 18.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                alignment: Alignment.center,
                width: 254.w,
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.grayAccent),
                ),
                child: TextField(
                  cursorColor: AppColors.gray,
                  style: AppStyles.helper7.copyWith(fontSize: 18.r),
                  decoration: const InputDecoration.collapsed(hintText: ''),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: onCancelTap,
                      child: Text(
                        'Cancel',
                        style: AppStyles.helper5,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    GestureDetector(
                      onTap: onOkTap,
                      child: Text(
                        'Ok',
                        style: AppStyles.helper5
                            .copyWith(color: AppColors.grayAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
