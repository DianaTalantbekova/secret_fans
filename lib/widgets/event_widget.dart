import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/properties/event.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/recent_manager.dart';
import 'package:secret_fans/resources/app_colors.dart';
import 'package:secret_fans/resources/app_styles.dart';
import 'package:secret_fans/utils/uri_helper.dart';
import 'package:secret_fans/widgets/custom_avatar.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.contact});

  final Contact contact;

  String get parseEvent => switch (contact.events.first.label) {
        EventLabel.anniversary => '${contact.displayName}\'s anniversary',
        EventLabel.birthday => '${contact.displayName}\'s birthday',
        EventLabel.other => contact.events.first.label.name,
        EventLabel.custom => contact.events.first.customLabel,
      };

  String get parseDate {
    var date = DateTime.now();
    var month = date.month;
    var day = date.month;

    if (contact.events.first.day == day &&
        contact.events.first.month == month) {
      return 'Today';
    }
    date = date.copyWith(month: month, day: day);
    return DateFormat('MMMM dd').format(date);
  }

  bool get isBirthday => contact.events.first.label == EventLabel.birthday;

  @override
  Widget build(BuildContext context) {
    final RecentManager recentManager = context.read();
    return Container(
      width: 342.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.lightestBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grayAccent),
      ),
      child: Row(
        children: [
          _buildProfilePic(isBirthday: isBirthday),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  parseEvent,
                  style: AppStyles.helper4.copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parseDate,
                      style: AppStyles.helper7
                          .copyWith(color: AppColors.grayAccent),
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
                        width: 32.w,
                        height: 32.h,
                        color: AppColors.blueAccent,
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
                        width: 32.w,
                        height: 32.h,
                        color: AppColors.blueAccent,
                      ),
                    ),
                    SizedBox(width: 26.w),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePic({bool isBirthday = false}) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w),
      child: SizedBox(
        width: 92.w,
        height: 92.h,
        child: Stack(
          children: [
            Positioned.fill(
              child: Visibility(
                visible: isBirthday,
                child: Image.asset(
                  'assets/png/icons/fireworks.png',
                  fit: BoxFit.contain,
                  width: 92.w,
                  height: 92.h,
                ),
              ),
            ),
            Center(
              child: CustomAvatar(data: contact.photoOrThumbnail),
            ),
          ],
        ),
      ),
    );
  }
}
