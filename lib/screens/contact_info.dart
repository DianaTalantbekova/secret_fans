import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/contacts_manager.dart';
import 'package:secret_fans/managers/favorite_manager.dart';
import 'package:secret_fans/managers/premium_manager.dart';
import 'package:secret_fans/managers/recent_manager.dart';
import 'package:secret_fans/widgets/custom_avatar.dart';
import 'package:secret_fans/widgets/custom_tab_bar.dart';

import '../resources/resources.dart';
import '../utils/uri_helper.dart';
import 'premium_screen.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final RecentManager recentManager = context.read();
    final PremiumManager premiumManager = context.read();
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer2<ContactsManager, FavoriteManager>(
          builder: (context, provider, provider2, child) {
            final contact = provider.contact!;
            final isFavorite = provider2.favContacts.contains(contact);
            return Column(
              children: [
                Gap(20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      GestureDetector(
                        onTap: () =>
                            context.go('/contacts_screen/contact_info/edit'),
                        child: Image.asset(
                          'assets/png/icons/edit.png',
                          fit: BoxFit.contain,
                          width: 28.w,
                          height: 28.h,
                          color: AppColors.grayAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                CustomAvatar(
                  data: contact.photoOrThumbnail,
                  radius: 100.r,
                ),
                SizedBox(height: 16.h),
                Text(
                  contact.displayName,
                  style: AppStyles.helper4.copyWith(
                    fontSize: 30.r,
                    height: 38 / 30,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        var phone = contact.phones.firstOrNull?.number;
                        if (phone == null) {
                          return;
                        }
                        recentManager.call(contact);
                        UriHelper.tel(phone);
                      },
                      child: Image.asset(
                        'assets/png/icons/call.png',
                        fit: BoxFit.contain,
                        width: 32.w,
                        height: 32.h,
                      ),
                    ),
                    SizedBox(width: 30.w),
                    GestureDetector(
                      onTap: () {
                        var phone = contact.phones.firstOrNull?.number;
                        if (phone == null) {
                          return;
                        }
                        UriHelper.sms(phone);
                      },
                      child: Image.asset(
                        'assets/png/icons/message.png',
                        fit: BoxFit.contain,
                        width: 32.w,
                        height: 32.h,
                      ),
                    ),
                    SizedBox(width: 30.w),
                    GestureDetector(
                      onTap: () {
                        if (provider2.favContacts.length > 2 &&
                            !isFavorite &&
                            !premiumManager.isPremium) {
                          final route = MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const PremiumScreen();
                          });
                          Navigator.of(context, rootNavigator: true)
                              .push(route);
                          return;
                        }
                        provider2.setFavorite(contact);
                      },
                      child: Image.asset(
                        isFavorite
                            ? 'assets/png/icons/favorite_icon.png'
                            : 'assets/png/icons/fav_off.png',
                        fit: BoxFit.contain,
                        width: 32.w,
                        height: 32.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 28.h),
                CustomTabBar(
                  contact: contact,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
