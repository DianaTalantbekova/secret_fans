import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/favorite_manager.dart';
import 'package:secret_fans/managers/folders_manager.dart';

import '../resources/resources.dart';
import '../widgets/contact_info_widget.dart';
import '../widgets/widgets.dart';

class OpenedFolderScreen extends StatelessWidget {
  const OpenedFolderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer2<FoldersManager, FavoriteManager>(
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
                          fit: BoxFit.contain,
                          width: 28.w,
                          height: 28.h,
                        ),
                      ),
                      Text(
                        provider.folder!.name,
                        style: AppStyles.helper4,
                      ),
                      GestureDetector(
                        onTap: () => context.go(
                            '/folders_screen/opened_folder_screen/edit_contacts'),
                        child: Text(
                          'Edit',
                          style: AppStyles.helper5.copyWith(fontSize: 16.r),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 34.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.folder!.contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final contact = provider.folder!.contacts[index];
                      final isFavorite = provider2.ids.contains(contact.id);
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ContactInfoWidget(
                          contact: provider.folder!.contacts[index],
                          showLetter: false,
                          onTap: () =>
                              context.go('/contacts_screen/contact_info'),
                          isFavorite: isFavorite,
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
