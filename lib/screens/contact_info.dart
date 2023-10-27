import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Image.asset(
                      'assets/png/icons/back.png',
                      fit: BoxFit.contain,
                      width: 28.w,
                      height: 28.h,
                    ),
                  ),
                  _buildIcon()
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Image.asset(
              'assets/png/contact.png',
              fit: BoxFit.contain,
              width: 200.w,
              height: 200.h,
            ),
            SizedBox(height: 16.h),
            Text(
              'Anika Summers',
              style: AppStyles.helper4.copyWith(fontSize: 30.r),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Image.asset(
                    'assets/png/icons/call.png',
                    fit: BoxFit.contain,
                    width: 32.w,
                    height: 32.h,
                  ),
                ),
                SizedBox(width: 30.w),
                GestureDetector(
                  onTap: () => _newTagNameDialog(context),
                  child: Image.asset(
                    'assets/png/icons/message.png',
                    fit: BoxFit.contain,
                    width: 32.w,
                    height: 32.h,
                  ),
                ),
                SizedBox(width: 30.w),
                GestureDetector(
                  onTap: () => _deleteContactDialog(context),
                  child: Image.asset(
                    'assets/png/icons/favorite_icon.png',
                    fit: BoxFit.contain,
                    width: 32.w,
                    height: 32.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 28.h),
                DefaultTabController(
                  initialIndex: 1,
                  length: 3,
                  child: TabBar(
                    indicatorColor: Colors.transparent,
                    tabs: [
                      Tab(
                        child: Image.asset(
                          'assets/png/icons/info.png',
                          fit: BoxFit.contain,
                          width: 35.w,
                          height: 35.h,
                        ),
                      ),
                      Tab(
                        child: Image.asset(
                          'assets/png/icons/calender.png',
                          fit: BoxFit.contain,
                          width: 35.w,
                          height: 35.h,
                        ),
                      ),
                      Tab(
                        child: Image.asset(
                          'assets/png/icons/photo.png',
                          fit: BoxFit.contain,
                          width: 35.w,
                          height: 35.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ],

        ),
      ),
    );
  }

  Widget _buildIcon({bool isDelete = false}) {
    if (isDelete) {
      return Image.asset(
        'assets/png/icons/bin.png',
        fit: BoxFit.contain,
        width: 36.w,
        height: 36.h,
      );
    }
    return Image.asset(
      'assets/png/icons/edit.png',
      fit: BoxFit.contain,
      width: 28.w,
      height: 28.h,
      color: AppColors.grayAccent,
    );
  }

  Future<void> _deleteContactDialog(BuildContext context) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          onCancelTap: context.pop,
          onDeleteTap: () {},
          text: 'contact',
        );
      },
    );
  }

  Future<void> _newTagNameDialog(BuildContext context) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return TextFieldDialog(
          onCancelTap: context.pop,
          onOkTap: () {},
          text: 'New tag name',
        );
      },
    );
  }
}
