import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class MoveFoldersScreen extends StatelessWidget {
  const MoveFoldersScreen({super.key});

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
            MoveFoldersScreen()
          ],
        ),
      ),
    );
  }
}
