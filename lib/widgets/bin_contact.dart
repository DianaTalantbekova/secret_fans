import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:secret_fans/widgets/custom_avatar.dart';

import '../resources/app_styles.dart';

class BinContact extends StatelessWidget {
  const BinContact({super.key, required this.contact, this.onTap});

  final Contact contact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 45.w),
      child: Row(
        children: [
          CustomAvatar(data: contact.photoOrThumbnail, radius: 30.r),
          Gap(10.w),
          Text(
            contact.displayName,
            style: AppStyles.helper4,
          ),
          Gap(10.w),
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
