import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_fans/screens/premium_screen.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            TextFieldWidget(),
            SizedBox(height: 25.h),
            Text(
              'Settings',
              style: AppStyles.helper4,
            ),
            SizedBox(height: 30.h),
            CustomButton3(
              asset: 'assets/png/icons/crown.png',
              text: 'Premium',
              onTap: () => _onPremiumTap(context),
            ),
            SizedBox(height: 16.h),
            CustomButton3(
              onTap: () => context.go('/settings_screen/password_change'),
              asset: 'assets/png/icons/shield.png',
              text: 'Password',
            ),
            SizedBox(height: 16.h),
            CustomButton3(
              onTap: () => context.go('/settings_screen/tags_screen'),
              asset: 'assets/png/icons/tag.png',
              text: 'Tags',
            ),
            SizedBox(height: 16.h),
            CustomButton3(
              onTap: () => context.go('/settings_screen/bin_screen'),
              asset: 'assets/png/icons/bin.png',
              text: 'Bin',
            ),
            SizedBox(height: 16.h),
            CustomButton3(
              onTap: () {},
              text: 'Terms of Use',
              isBlue: false,
              hasBorder: true,
            ),
            SizedBox(height: 16.h),
            CustomButton3(
              onTap: () {},
              text: 'Privacy Policy',
              isBlue: false,
              hasBorder: true,
            ),
            SizedBox(height: 16.h),
            CustomButton3(
              onTap: () {},
              text: 'Support',
              isBlue: false,
              hasBorder: true,
            ),
          ],
        ),
      ),
    );
  }

  _onPremiumTap(BuildContext context) {
    final route = MaterialPageRoute(builder: (BuildContext context) {
      return const PremiumScreen();
    });
    Navigator.of(context, rootNavigator: true).push(route);
  }
}
