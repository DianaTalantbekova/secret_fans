import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class BinScreen extends StatelessWidget {
  const BinScreen({super.key});

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
                        'Bin',
                        style: AppStyles.helper4,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                ],
              ),
            ),
            // SizedBox(height: 265.h),
            // Text(
            //   'Bin is empty',
            //   style: AppStyles.helper8,
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 45.w),
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
                  GestureDetector(
                    onTap: (){},
                    child: Image.asset(
                      'assets/png/icons/bin.png',
                      fit: BoxFit.contain,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(left: 45.w),
              child: Row(
                children: [
                  Image.asset(
                    'assets/png/folder_1.png',
                    fit: BoxFit.contain,
                    width: 60.w,
                    height: 60.h,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Friends',
                    style: AppStyles.helper4,
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () => _deleteDialog(context),
                    child: Image.asset(
                      'assets/png/icons/bin.png',
                      fit: BoxFit.contain,
                      width: 24.w,
                      height: 24.h,
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

  Future<void> _deleteDialog(BuildContext context) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          onCancelTap: context.pop,
          onDeleteTap: () {},
          text: 'permanently',
        );
      },
    );
  }
}
