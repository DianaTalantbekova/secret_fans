import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../managers/password_manager.dart';
import '../resources/resources.dart';
import '../widgets/widgets.dart';

class PasswordChange extends StatelessWidget {
  const PasswordChange({super.key});

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
                        'Password',
                        style: AppStyles.helper4,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                ],
              ),
            ),
            SizedBox(height: 98.h),
            CustomButton3(
              onTap: () {
                context.read<PasswordManager>().createPassState =
                    CreatePassState.change;
                context.go('/settings_screen/password_change/change');
              },
              asset: 'assets/png/icons/edit.png',
              text: 'Change',
            ),
            SizedBox(height: 12.h),
            CustomButton3(
              onTap: () => _deletePasswordDialog(context),
              asset: 'assets/png/icons/bin.png',
              text: 'Delete',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deletePasswordDialog(BuildContext context) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          onCancelTap: context.pop,
          onDeleteTap: () {
            context.read<PasswordManager>().deletePassword();
            context
              ..pop()
              ..pop();
          },
          text: 'password',
        );
      },
    );
  }
}
