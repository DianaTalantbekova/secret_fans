import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blue,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/png/onboarding1.png',
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
                    'Welcome!',
                    style: AppStyles.helper1,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'All your private contacts\nin one app',
                    style: AppStyles.helper2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 89.h,
                  ),
                  CustomButton1(
                    onTap: () => context.go('/onboarding2'),
                    text: 'Continue',
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
