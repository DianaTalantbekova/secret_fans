import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class EditContactInFolder extends StatelessWidget {
  const EditContactInFolder({super.key});

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
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Image.asset(
                      'assets/png/icons/back.png',
                      fit: BoxFit.contain,
                      width: 28.w,
                      height: 28.h,
                    ),
                  ),
                  SizedBox(width: 26.w),
                  Text(
                    'Edit contacts',
                    style: AppStyles.helper4,
                  ),
                  const Spacer(),
                  SaveButton(
                    onTap: (){},
                  )
                ],
              ),
            ),
            SizedBox(height: 28.h),
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
                  _buildIcon(canRemove: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildIcon({
    bool selected = false,
    bool canRemove = false,
  }) {
    if(selected){
      return Image.asset(
        'assets/png/icons/check.png',
        fit: BoxFit.contain,
        width: 24.w,
        height: 24.h,
      );
    } if(canRemove){
      return Image.asset(
        'assets/png/icons/close_sign.png',
        fit: BoxFit.contain,
        width: 24.w,
        height: 24.h,
      );
    }
    return const SizedBox();
  }
}
