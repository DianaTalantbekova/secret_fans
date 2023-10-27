import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secret_fans/resources/app_styles.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({
    super.key,
    this.isOutgoingCall = true,
  });

  final bool isOutgoingCall;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 326.w,
      height: 60.h,
      child: Row(
        children: [
          Image.asset(
            'assets/png/contact.png',
            fit: BoxFit.contain,
            width: 60.w,
            height: 60.h,
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
              ? 'assets/png/icons/outgoing_call.png'
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
                        'Today',
                        style: AppStyles.helper6.copyWith(fontSize: 10.r),
                      ),
                      Text(
                        '5:30 PM',
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
            onTap: () {},
            child: Image.asset(
              'assets/png/icons/call.png',
              fit: BoxFit.contain,
              width: 36.w,
              height: 36.h,
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {},
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
            'Anika Summers',
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
