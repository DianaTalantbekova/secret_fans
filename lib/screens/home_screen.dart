import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
TextFieldWidget(),
            SizedBox(height: 32.h),
            SizedBox(
              width: 338.w,
              height: 270.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recents',
                        style: AppStyles.helper4,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'See all',
                          style: AppStyles.helper5.copyWith(fontSize: 16.r),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 83.h),
                  // Text(
                  //   'No recents',
                  //   style: AppStyles.helper8,
                  // ),
                  SizedBox(height: 20.h),
                  ContactWidget(),
                  SizedBox(height: 20.h),
                  ContactWidget(
                    isOutgoingCall: false,
                  ), SizedBox(height: 20.h),
                  ContactWidget(
                    isOutgoingCall: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            SizedBox(
              width: 338.w,
              height: 270.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Events',
                        style: AppStyles.helper4,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'See all',
                          style: AppStyles.helper5.copyWith(fontSize: 16.r),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 83.h),
                  // Text(
                  //   'No events',
                  //   style: AppStyles.helper8,
                  // ),
                  SizedBox(height: 20.h),
                  const EventWidget(),
                  SizedBox(height: 20.h),
                  const EventWidget(),
                ],
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
