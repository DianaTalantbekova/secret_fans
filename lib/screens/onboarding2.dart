import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_fans/resources/app_styles.dart';
import 'package:secret_fans/widgets/custom_button1.dart';

import '../resources/app_colors.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blue,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/png/onboarding2.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 46.h,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                children: [
                  Text(
                    'Customize contacts',
                    style: AppStyles.helper1,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Create tags, folders and\nmeetings with your contacts',
                    style: AppStyles.helper2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 89.h,
                  ),
                  CustomButton1(
                    onTap: () => context.go('/create_pass'),
                    text: 'Start',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
