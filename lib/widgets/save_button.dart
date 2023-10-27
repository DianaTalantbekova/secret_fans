import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    this.width,
    this.height,
    this.onTap,
    this.text,
  });

  final double? width;
  final double? height;
  final String? text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        width: width ?? 80.w,
        height: height ?? 36.h,
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Text(
          text ?? 'Save',
          style: AppStyles.helper4,
        ),
      ),
    );
  }
}
