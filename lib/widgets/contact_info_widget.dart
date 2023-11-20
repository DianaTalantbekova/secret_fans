import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secret_fans/widgets/custom_avatar.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({
    super.key,
    required this.contact,
    this.showLetter = false,
    this.searchText = '',
    required this.onTap,
    this.suffixIcon,
    this.isFavorite = false,
  });

  final Contact contact;
  final bool showLetter;
  final String searchText;
  final VoidCallback onTap;
  final Widget? suffixIcon;
  final bool isFavorite;

  List<String> get displayName {
    var temp = contact.displayName.replaceFirst(searchText, '*').split('*');
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          SizedBox(
            width: 42.w,
            child: showLetter
                ? Text(
                    contact.displayName[0],
                    style: AppStyles.helper8.copyWith(
                      color: AppColors.blueAccent,
                    ),
                  )
                : null,
          ),
          GestureDetector(
            onTap: onTap,
            child: SizedBox(
              child: Row(
                children: [
                  CustomAvatar(data: contact.photoOrThumbnail),
                  SizedBox(width: 10.w),
                  _buildName(),
                  SizedBox(width: 10.w),
                  suffixIcon ?? _buildIcon(isFavorite: isFavorite),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon({bool isFavorite = false}) {
    if (isFavorite) {
      return Image.asset(
        'assets/png/icons/favorite_icon.png',
        fit: BoxFit.contain,
        width: 24.w,
        height: 24.h,
      );
    }
    return const SizedBox();
  }

  Widget _buildName() {
    if (searchText.isEmpty) {
      return Text(
        contact.displayName,
        style: AppStyles.helper4,
      );
    }
    return Row(
      children: [
        Text(
          displayName[0],
          style: AppStyles.helper4,
        ),
        Text(
          searchText,
          style: AppStyles.helper4.copyWith(color: AppColors.blueAccent),
        ),
        Text(
          displayName[1],
          style: AppStyles.helper4,
        ),
      ],
    );
  }
}
