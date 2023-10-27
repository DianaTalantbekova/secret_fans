import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';
import 'custom_icon.dart';

class FolderWidget extends StatefulWidget {
  const FolderWidget({super.key});

  @override
  State<FolderWidget> createState() => _FolderWidgetState();
}

class _FolderWidgetState extends State<FolderWidget> {
  List<String> items = ['Delete', 'Rename', 'Edit contacts', 'Move'];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/folders_screen/opened_folder_screen'),
      child: Container(
        width: 334.w,
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.blueAccent),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/png/folder_1.png',
              fit: BoxFit.contain,
              width: 100.w,
              height: 100.h,
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Friends',
                  style:
                      AppStyles.helper9.copyWith(color: AppColors.grayAccent),
                ),
                SizedBox(height: 4.h),
                const CustomIcon(),
              ],
            ),
            SizedBox(width: 22.w),
            _buildIcon(isMenu: true)
          ],
        ),
      ),
    );
  }

  Widget _buildIcon({bool isMenu = true}) {
    if (isMenu) {
      return PopupMenuButton(
        padding: EdgeInsets.zero,
        color: AppColors.lightestBlue,
        elevation: 2,
        itemBuilder: (context) => items
            .map(
              (e) => PopupMenuItem(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 16.w,
                ),
                height: 20.h,
                child: Text(
                  e,
                  style: AppStyles.helper7,
                ),
              ),
            )
            .toList(),
        child: Image.asset(
          'assets/png/icons/menu.png',
          fit: BoxFit.contain,
          width: 36.w,
          height: 36.h,
        ),
      );
    }
    return Image.asset(
      'assets/png/icons/move.png',
      fit: BoxFit.contain,
      width: 36.w,
      height: 36.h,
    );
  }
}
