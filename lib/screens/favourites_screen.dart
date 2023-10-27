import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            TextFieldWidget(),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Favourites',
                    style: AppStyles.helper4,
                  ),
                  GestureDetector(
                    onTap: () => context.go('/favourites_screen/add_to_favourites_screen'),
                    child: Text(
                      'Add',
                      style: AppStyles.helper5.copyWith(fontSize: 16.r),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 192.h),
            // Text(
            //   'Here will be your\nfavorites',
            //   style: AppStyles.helper8,
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 44.h),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  childAspectRatio: 98.w / 140.h,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 98.w,
                    height: 140.h,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/png/contact.png',
                          fit: BoxFit.cover,
                          width: 98.w,
                          height: 98.h,
                        ),
                        Text(
                          'Anika Summers',
                          style: AppStyles.helper4.copyWith(fontSize: 16.r),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
