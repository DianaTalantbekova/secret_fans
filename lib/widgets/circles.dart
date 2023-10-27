import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';

class Circles extends StatelessWidget {
  const Circles({
    super.key,
    this.isEmpty = true,
  });

  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 20.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isEmpty ? AppColors.lightGray : AppColors.lightBlue,
      ),
    );
  }
}
