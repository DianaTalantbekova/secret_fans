import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:secret_fans/resources/app_colors.dart';
import 'package:secret_fans/widgets/calendar_tab.dart';
import 'package:secret_fans/widgets/images_tab.dart';
import 'package:secret_fans/widgets/info_tab.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342.w,
      height: 300.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/png/tabs/tab1_off.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(6.h),
                      Padding(
                        padding: EdgeInsets.only(left: 40.w),
                        child: Image.asset(
                          'assets/png/icons/info.png',
                          width: 35.w,
                          height: 35.h,
                          fit: BoxFit.contain,
                          color: AppColors.grayAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/png/tabs/tab2_off.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(6.h),
                      Padding(
                        padding: EdgeInsets.only(left: 153.w),
                        child: Image.asset(
                          'assets/png/icons/calendar.png',
                          width: 35.w,
                          height: 35.h,
                          fit: BoxFit.contain,
                          color: AppColors.grayAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/png/tabs/tab3_off.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(6.h),
                      Padding(
                        padding: EdgeInsets.only(left: 267.w),
                        child: Image.asset(
                          'assets/png/icons/photo.png',
                          width: 35.w,
                          height: 35.h,
                          fit: BoxFit.contain,
                          color: AppColors.grayAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16.h,
            left: 113.5.w,
            child: Visibility(
              visible: index == 2,
              child: Container(
                width: 1.r,
                height: 27.h,
                color: AppColors.grayAccent,
              ),
            ),
          ),
          Positioned(
            top: 16.h,
            left: 227.5.w,
            child: Visibility(
              visible: index == 0,
              child: Container(
                width: 1.r,
                height: 27.h,
                color: AppColors.grayAccent,
              ),
            ),
          ),
          Positioned.fill(
            child: IndexedStack(
              index: index,
              children: [
                InfoTab(contact: widget.contact),
                CalendarTab(contact: widget.contact),
                ImagesTab(
                  contact: widget.contact,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => index = 0),
                    child: Container(
                      height: 47.h,
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => index = 1),
                    child: Container(
                      height: 47.h,
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => index = 2),
                    child: Container(
                      height: 47.h,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
