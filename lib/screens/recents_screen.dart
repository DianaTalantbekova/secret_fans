import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/favorite_manager.dart';

import '../managers/recent_manager.dart';
import '../resources/app_styles.dart';
import '../widgets/widgets.dart';

class RecentsScreen extends StatelessWidget {
  const RecentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer2<RecentManager, FavoriteManager>(
          builder: (context, provider, provider2, child) {
            return Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: context.pop,
                        child: Image.asset(
                          'assets/png/icons/back.png',
                          width: 32.w,
                          height: 32.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        'Recents',
                        style: AppStyles.helper4,
                      ),
                      Gap(32.w),
                    ],
                  ),
                ),
                Gap(15.h),
                if (provider.firstThree.isEmpty) ...[
                  Expanded(
                    child: Center(
                      child: Text(
                        'No recents',
                        style: AppStyles.helper8,
                      ),
                    ),
                  ),
                ] else
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.recentList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final contact = provider.recentList[index];
                        final isFavorite =
                            provider2.favContacts.contains(contact);
                        final dateTime = provider.dates[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 32.w,
                          ),
                          child: ContactWidget(
                            contact: contact,
                            isFavorite: isFavorite,
                            dateTime: dateTime,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
