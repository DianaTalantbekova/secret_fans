import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      width: 342.w,
      height: 42.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.lightestBlue,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/png/icons/search.png',
              fit: BoxFit.contain,
              width: 24.w,
              height: 24.h,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              cursorColor: AppColors.gray,
              style: AppStyles.helper7,
              decoration: InputDecoration.collapsed(
                hintText: 'Search contacts',
                hintStyle: AppStyles.helper6.copyWith(fontSize: 16.r),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/png/icons/close.png',
              fit: BoxFit.contain,
              width: 16.w,
              height: 16.h,
            ),
          ),
        ],
      ),
    );
  }
}
