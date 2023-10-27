import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: Image.asset(
                          'assets/png/icons/back.png',
                          fit: BoxFit.contain,
                          width: 28.w,
                          height: 28.h,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Tags',
                        style: AppStyles.helper4,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Add',
                          style: AppStyles.helper5.copyWith(fontSize: 18.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 263.h),
            // Text(
            //   'Here will be your\ntags',
            //   style: AppStyles.helper8,
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 42.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomButton2(text: 'caffe'),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: (){},
                        child: Image.asset(
                          'assets/png/icons/close.png',
                          fit: BoxFit.contain,
                          width: 22.w,
                          height: 22.h,
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      CustomButton2(text: 'gym'),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: (){},
                        child: Image.asset(
                          'assets/png/icons/close.png',
                          fit: BoxFit.contain,
                          width: 22.w,
                          height: 22.h,
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTagDialog(BuildContext context) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          onCancelTap: context.pop,
          onDeleteTap: () {},
          text: 'tag',
        );
      },
    );
  }
}
