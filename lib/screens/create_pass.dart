import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/password_manager.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class CreatePass extends StatelessWidget {
  const CreatePass({super.key, required this.hasSkip});

  final bool hasSkip;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer<PasswordManager>(
          builder: (context, provider, child) {
            return Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: !hasSkip,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: context.pop,
                              child: Image.asset(
                                'assets/png/icons/back.png',
                                fit: BoxFit.contain,
                                width: 28.w,
                                height: 28.h,
                              ),
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
                      Expanded(
                        child: Visibility(
                          visible: hasSkip && !provider.hasPassword,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Skip',
                                style: AppStyles.helper5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 69.h),
                Text(
                  provider.labelText,
                  style: AppStyles.helper4,
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    provider.passLength,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Circles(isEmpty: provider.isEmpty(index)),
                    ),
                  ),
                ),
                SizedBox(height: 60.h),
                GridView(
                  padding: EdgeInsets.symmetric(horizontal: 67.w),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20.h,
                    crossAxisSpacing: 20.w,
                  ),
                  children: List.generate(
                    9,
                    (index) => CustomCircleButton(
                      digit: index + 1,
                      onTap: () => provider.enterPass('${index + 1}'),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 67.w),
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox.shrink()),
                      Expanded(
                        flex: 2,
                        child: CustomCircleButton(
                          digit: 0,
                          onTap: () => provider.enterPass('0'),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: provider.removePass,
                          child: Image.asset(
                            'assets/png/icons/backspace.png',
                            fit: BoxFit.contain,
                            width: 72.w,
                            height: 72.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  provider.isWrongPassword
                      ? 'Wrong password\nPlease try again'
                      : 'Password adds an extra layer of security\nwhen using the app',
                  style: AppStyles.helper6.copyWith(
                      color: provider.isWrongPassword ? Colors.red : null),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
