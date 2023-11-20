import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/folder.dart';
import '../resources/app_styles.dart';

class BinFolder extends StatelessWidget {
  const BinFolder({super.key, required this.folder, this.onTap});

  final Folder folder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 45.w),
      child: Row(
        children: [
          Image.asset(
            'assets/png/folder_1.png',
            fit: BoxFit.contain,
            width: 60.w,
            height: 60.h,
          ),
          SizedBox(width: 10.w),
          Text(
            folder.name,
            style: AppStyles.helper4,
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: onTap,
            child: Image.asset(
              'assets/png/icons/bin.png',
              fit: BoxFit.contain,
              width: 24.w,
              height: 24.h,
            ),
          ),
        ],
      ),
    );
  }
}
