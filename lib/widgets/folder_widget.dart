import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/folder.dart';
import '../resources/app_colors.dart';
import '../resources/app_styles.dart';
import 'custom_icon.dart';

class FolderWidget extends StatelessWidget {
  FolderWidget({
    super.key,
    required this.folder,
    this.onDelete,
    this.onRename,
    this.onEdit,
    this.onMove,
    this.onTap,
    this.isMenu = true,
  });

  final Folder folder;
  final VoidCallback? onDelete;
  final VoidCallback? onRename;
  final VoidCallback? onEdit;
  final VoidCallback? onMove;
  final VoidCallback? onTap;
  final bool isMenu;

  final List<String> items = ['Delete', 'Rename', 'Edit contacts', 'Move'];

  late final List<VoidCallback?> actions = [
    onDelete,
    onRename,
    onEdit,
    onMove,
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  folder.name,
                  style:
                      AppStyles.helper9.copyWith(color: AppColors.grayAccent),
                ),
                SizedBox(height: 4.h),
                CustomIcon(contacts: folder.contacts),
              ],
            ),
            SizedBox(width: 22.w),
            _buildIcon(isMenu: isMenu)
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
                onTap: () => actions[items.indexOf(e)]?.call(),
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
