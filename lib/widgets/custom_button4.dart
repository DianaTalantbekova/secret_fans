import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class CustomButton4 extends StatelessWidget {
  const CustomButton4({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/png/icons/new_contact.png',
          fit: BoxFit.contain,
          width: 30.w,
          height: 30.h,
        ),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'Create new contact',
            style: AppStyles.helper4.copyWith(color: AppColors.blueAccent),
          ),
        ),
      ],
    );
  }
}
