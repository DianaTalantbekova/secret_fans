import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({
    super.key,
    this.onTap,
    required this.digit,
  });

  final VoidCallback? onTap;
  final int digit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 72.w,
        height: 72.h,
        decoration: const BoxDecoration(
          color: AppColors.lightestBlue,
          shape: BoxShape.circle,
        ),
        child: Text(
          '$digit',
          style: AppStyles.helper4.copyWith(
            fontSize: 30.r,
          ),
        ),
      ),
    );
  }
}
