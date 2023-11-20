import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/favorite_manager.dart';
import 'package:secret_fans/widgets/custom_avatar.dart';

import '../resources/resources.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer<FavoriteManager>(
          builder: (context, provider, child) {
            return Column(
              children: [
                SizedBox(height: 20.h),
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
                        onTap: () => context
                            .go('/favourites_screen/add_to_favourites_screen'),
                        child: Text(
                          'Add',
                          style: AppStyles.helper5.copyWith(fontSize: 16.r),
                        ),
                      ),
                    ],
                  ),
                ),
                if (provider.favContacts.isEmpty) ...[
                  SizedBox(height: 192.h),
                  Text(
                    'Here will be your\nfavorites',
                    style: AppStyles.helper8,
                    textAlign: TextAlign.center,
                  ),
                ],
                SizedBox(height: 44.h),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    itemCount: provider.favContacts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 98.w / 140.h,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final contact = provider.favContacts[index];
                      return SizedBox(
                        width: 98.w,
                        height: 140.h,
                        child: Column(
                          children: [
                            CustomAvatar(
                              data: contact.photoOrThumbnail,
                              radius: 49.r,
                            ),
                            Gap(2.h),
                            Text(
                              contact.displayName,
                              style: AppStyles.helper7.copyWith(
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
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
