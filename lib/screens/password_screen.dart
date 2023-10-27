import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: Image.asset(
                          'assets/png/icons/back.png',
                          fit: BoxFit.contain,
                          width: 32.w,
                          height: 32.h,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Password',
                        style: AppStyles.helper4,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                ],
              ),
            ),
            SizedBox(height: 69.h),
            Text(
              'Enter password',
              style: AppStyles.helper4,
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Circles(isEmpty: false),
                SizedBox(width: 12.w),
                Circles(isEmpty: false),
                SizedBox(width: 12.w),
                Circles(isEmpty: false),
                SizedBox(width: 12.w),
                Circles(isEmpty: false),
              ],
            ),
            SizedBox(height: 60.h),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleButton(digit: 1),
                    SizedBox(width: 20.w),
                    CustomCircleButton(digit: 2),
                    SizedBox(width: 20.w),
                    CustomCircleButton(digit: 3),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleButton(digit: 4),
                    SizedBox(width: 20.w),
                    CustomCircleButton(digit: 5),
                    SizedBox(width: 20.w),
                    CustomCircleButton(digit: 6),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleButton(digit: 7),
                    SizedBox(width: 20.w),
                    CustomCircleButton(digit: 8),
                    SizedBox(width: 20.w),
                    CustomCircleButton(digit: 9),
                  ],
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 67.w),
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox.shrink()),
                      Expanded(
                        flex: 2,
                        child: CustomCircleButton(digit: 0),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/png/icons/backspace.png',
                            fit: BoxFit.contain,
                            width: 72.w,
                            height: 72.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              'Password adds an extra layer of security\nwhen using the app',
              style: AppStyles.helper6,
              textAlign: TextAlign.center,
            ),
            // Text(
            //   'Wrong password\nPlease try again',
            //   style: AppStyles.helper7.copyWith(color: AppColors.red),
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
