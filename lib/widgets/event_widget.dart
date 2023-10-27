import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secret_fans/resources/app_colors.dart';
import 'package:secret_fans/resources/app_styles.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.lightestBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grayAccent),
      ),
      child: Row(
        children: [
          _buildProfilePic(isBirthday: true
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Adriana Tyler’s birthday',
                  style: AppStyles.helper4.copyWith(fontSize: 16),
                ),
                SizedBox(height: 8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today',
                      style: AppStyles.helper7
                          .copyWith(color: AppColors.grayAccent),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/png/icons/call.png',
                        fit: BoxFit.contain,
                        width: 32.w,
                        height: 32.h,
                        color: AppColors.blueAccent,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/png/icons/message.png',
                        fit: BoxFit.contain,
                        width: 32.w,
                        height: 32.h,
                        color: AppColors.blueAccent,
                      ),
                    ),
                    SizedBox(width: 26.w),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePic({bool isBirthday = false}) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w),
      child: SizedBox(
        width: 92.w,
        height: 92.h,
        child: Stack(
          children: [
            Positioned.fill(
              child: Visibility(
                visible: isBirthday,
                child: Image.asset(
                  'assets/png/icons/fireworks.png',
                  fit: BoxFit.contain,
                  width: 92.w,
                  height: 92.h,
                ),
              ),
            ),
            Center(
              child: Image.asset(
                'assets/png/contact.png',
                fit: BoxFit.contain,
                width: 60.w,
                height: 60.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
