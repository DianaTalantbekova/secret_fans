import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/resources/app_styles.dart';
import 'package:secret_fans/widgets/custom_avatar.dart';

import '../managers/recent_manager.dart';
import '../utils/uri_helper.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    super.key,
    this.isOutgoingCall = true,
    this.isFavorite = false,
    required this.contact,
    required this.dateTime,
  });

  final bool isOutgoingCall;
  final bool isFavorite;
  final Contact contact;
  final DateTime dateTime;

  String get parseDate {
    var date = DateTime.now();
    var year = date.year;
    var month = date.month;
    var day = date.day;
    if (dateTime.year == year &&
        dateTime.month == month &&
        dateTime.day == day) {
      return 'Today';
    } else if (dateTime.year == year &&
        dateTime.month == month &&
        dateTime.day == day - 1) {
      return 'Yesterday';
    }
    return DateFormat('MMMM dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final RecentManager recentManager = context.read();
    return SizedBox(
      width: 326.w,
      height: 60.h,
      child: Row(
        children: [
          CustomAvatar(
            data: contact.photoOrThumbnail,
            radius: 30.r,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFavorites(isFavorite: true),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Image.asset(
                    isOutgoingCall
                        ? 'assets/png/icons/incoming_call.png'
                        : 'assets/png/icons/missed_call.png',
                    fit: BoxFit.contain,
                    width: 28.w,
                    height: 28.h,
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        parseDate,
                        style: AppStyles.helper6.copyWith(fontSize: 10.r),
                      ),
                      Text(
                        DateFormat.jm().format(dateTime),
                        style: AppStyles.helper6.copyWith(fontSize: 10.r),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
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
              width: 36.w,
              height: 36.h,
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              var phone = contact.phones.firstOrNull?.number;
              if (phone == null) {
                return;
              }
              recentManager.call(contact);
              UriHelper.sms(phone);
            },
            child: Image.asset(
              'assets/png/icons/message.png',
              fit: BoxFit.contain,
              width: 36.w,
              height: 36.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavorites({bool isFavorite = false}) {
    if (isFavorite) {
      return Row(
        children: [
          Text(
            contact.displayName,
            style: AppStyles.helper4.copyWith(fontSize: 16),
          ),
          SizedBox(width: 8.w),
          Image.asset(
            'assets/png/icons/favorite_icon.png',
            fit: BoxFit.contain,
            width: 24.w,
            height: 24.h,
          ),
        ],
      );
    }
    return Text(
      'Anika Summers',
      style: AppStyles.helper4.copyWith(fontSize: 16.r),
    );
  }
}
