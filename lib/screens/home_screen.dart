import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/contacts_manager.dart';
import 'package:secret_fans/managers/favorite_manager.dart';
import 'package:secret_fans/managers/recent_manager.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer<FavoriteManager>(
          builder: (context, favoriteManager, child) {
            return Column(
              children: [
                SizedBox(height: 20.h),
                Consumer<RecentManager>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      width: 338.w,
                      height: 270.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Recents',
                                style: AppStyles.helper4,
                              ),
                              GestureDetector(
                                onTap: () => context.go('/home_screen/recents'),
                                child: Text(
                                  'See all',
                                  style: AppStyles.helper5
                                      .copyWith(fontSize: 16.r),
                                ),
                              ),
                            ],
                          ),
                          if (provider.firstThree.isEmpty) ...[
                            SizedBox(height: 83.h),
                            Text(
                              'No recents',
                              style: AppStyles.helper8,
                            ),
                          ] else
                            ...List.generate(
                              provider.firstThree.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: ContactWidget(
                                  contact: provider.firstThree[index],
                                  isFavorite:
                                      favoriteManager.favContacts.contains(
                                    provider.firstThree[index],
                                  ),
                                  dateTime: provider.dates[index],
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 40.h),
                Consumer<ContactsManager>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      width: 338.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Events',
                                style: AppStyles.helper4,
                              ),
                              GestureDetector(
                                onTap: () => context.go('/home_screen/events'),
                                child: Text(
                                  'See all',
                                  style: AppStyles.helper5
                                      .copyWith(fontSize: 16.r),
                                ),
                              ),
                            ],
                          ),
                          if (provider.contactsWithEvents.isEmpty) ...[
                            SizedBox(height: 83.h),
                            Text(
                              'No events',
                              style: AppStyles.helper8,
                            ),
                          ] else
                            ...List.generate(
                              provider.contactsWithEvents.take(2).length,
                              (index) => Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: EventWidget(
                                  contact: provider.contactsWithEvents[index],
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 8.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
