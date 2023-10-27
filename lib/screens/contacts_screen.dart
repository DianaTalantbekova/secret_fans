import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const TextFieldWidget(),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  CustomButton2(
                    onTap: () {},
                    text: 'club',
                    selected: true,
                  ),
                  SizedBox(width: 10.w),
                  CustomButton2(
                    onTap: () {},
                    text: 'caffe',
                  ),
                  SizedBox(width: 10.w),
                  CustomButton2(
                    onTap: () {},
                    text: 'gym',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/png/icons/new_contact.png',
                  fit: BoxFit.contain,
                  width: 30.w,
                  height: 30.h,
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: ()=> context.go('/contacts_screen/create_new_contact'),
                  child: Text(
                    'Create new contact',
                    style:
                        AppStyles.helper4.copyWith(color: AppColors.blueAccent),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 205.h),
            // Text(
            //   'Here will be your\ncontacts',
            //   style: AppStyles.helper8,
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Text(
                    'A',
                    style: AppStyles.helper8.copyWith(
                      color: AppColors.blueAccent,
                    ),
                  ),
                  SizedBox(width: 22.w),
                  GestureDetector(
                    onTap: () => context.go('/contacts_screen/contact_info'),
                    child: SizedBox(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/png/contact.png',
                            fit: BoxFit.contain,
                            width: 60.w,
                            height: 60.h,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Adriana Tyler',
                            style: AppStyles.helper4,
                          ),
                          SizedBox(width: 10.w),
                          _buildIcon(isFavorite: true),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIcon({bool isFavorite = false}) {
    if (isFavorite) {
      return Image.asset(
        'assets/png/icons/favorite_icon.png',
        fit: BoxFit.contain,
        width: 24.w,
        height: 24.h,
      );
    }
    return const SizedBox();
  }
}
