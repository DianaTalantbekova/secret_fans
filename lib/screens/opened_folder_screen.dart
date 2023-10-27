import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';


class OpenedFolderScreen extends StatelessWidget {
  const OpenedFolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const TextFieldWidget(),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/png/icons/back.png',
                      fit: BoxFit.contain,
                      width: 28.w,
                      height: 28.h,
                    ),
                  ),
                  Text(
                    'Friends',
                    style: AppStyles.helper4,
                  ),
                  GestureDetector(
                    onTap: () => context.go('/folders_screen/opened_folder_screen/edit_contact_in_folder'),
                    child: Text(
                      'Edit',
                      style: AppStyles.helper5.copyWith(fontSize: 16.r),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 189.h),
            // Text(
            //   'Here will be your\nfoldes',
            //   style: AppStyles.helper8,
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 30.h),
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
