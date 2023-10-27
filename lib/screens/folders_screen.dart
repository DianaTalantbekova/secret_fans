import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const TextFieldWidget(),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Folders',
                    style: AppStyles.helper4,
                  ),
                  GestureDetector(
                    onTap: () => _newFolderDialog(context),
                    child: Text(
                      'Create',
                      style: AppStyles.helper5.copyWith(fontSize: 16.r),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 189.h),
            // Text(
            //   'Here will be your\nfoldes',
            //   style: AppStyles.helper8,
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 30.h),

            FolderWidget(),
            SizedBox(height: 38.h),
          ],
        ),
      ),
    );
  }

  Future<void> _newFolderDialog(BuildContext context) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return TextFieldDialog(
          onCancelTap: context.pop,
          onOkTap: () {},
          text: 'New folder name',
        );
      },
    );
  }

  Future<void> _deleteFolderDialog(BuildContext context) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          onCancelTap: context.pop,
          onDeleteTap: () {},
          text: 'folder',
        );
      },
    );
  }
}
