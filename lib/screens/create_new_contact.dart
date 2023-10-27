import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class CreateNewContact extends StatelessWidget {
  const CreateNewContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 24.w),
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
            SizedBox(height: 10.h),
            Image.asset(
              'assets/png/without_photo.png',
              fit: BoxFit.contain,
              width: 160.w,
              height: 160.h,
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/png/icons/edit.png',
                      fit: BoxFit.contain,
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Upload photo',
                      style: AppStyles.helper5.copyWith(fontSize: 16.r),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Image.asset(
                    'assets/png/icons/contact_icon.png',
                    fit: BoxFit.contain,
                    width: 28.w,
                    height: 28.h,
                  ),
                  SizedBox(width: 16.w),
                  ProfileTextField(
                    title: 'Name',
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            ProfileTextField(
              title: 'Surname',
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Image.asset(
                    'assets/png/icons/call.png',
                    fit: BoxFit.contain,
                    width: 28.w,
                    height: 28.h,
                  ),
                  SizedBox(width: 16.w),
                  ProfileTextField(
                    title: 'Number',
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Image.asset(
                    'assets/png/icons/birthday.png',
                    fit: BoxFit.contain,
                    width: 28.w,
                    height: 28.h,
                  ),
                  SizedBox(width: 16.w),
                  ProfileTextField(
                    title: 'Birthday',
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Image.asset(
                    'assets/png/icons/tag.png',
                    fit: BoxFit.contain,
                    width: 28.w,
                    height: 28.h,
                    color: AppColors.lightBlue,
                  ),
                  SizedBox(width: 16.w),
                  ProfileTextField(
                    title: 'Tags',
                  ),
                ],
              ),
            ),
            const Spacer(),
            SaveButton(
              onTap: () {},
              width: 174.w,
              height: 48.h,
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
