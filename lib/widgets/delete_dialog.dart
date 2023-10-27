import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.text,
    this.onCancelTap,
    this.onDeleteTap,
  });

  final String text;
  final VoidCallback? onCancelTap;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 270.h),
          width: 302.w,
          height: 116.h,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Delete $text?',
                style: AppStyles.helper4,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onCancelTap,
                    child: Text(
                      'Cancel',
                      style: AppStyles.helper5.copyWith(fontSize: 24.r),
                    ),
                  ),
                  SizedBox(width: 32.w),
                  GestureDetector(
                    onTap: onDeleteTap,
                    child: Text(
                      'Delete',
                      style: AppStyles.helper9,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
