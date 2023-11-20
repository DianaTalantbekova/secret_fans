import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';
import 'custom_date_picker_dialog.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key, required this.contact});

  final Contact contact;

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  List<Event> get meetings => widget.contact.events
      .where((element) => element.customLabel.contains('Meeting'))
      .toList();

  String? get upcomingMeeting {
    if (meetings.isEmpty) {
      return null;
    }
    var date = DateTime.now();
    DateTime? meetDate;
    for (var item in meetings) {
      if (item.year == null) {
        continue;
      }
      var temp = DateTime(item.year!, item.month, item.day);
      if (date.isBefore(temp)) {
        if (meetDate == null) {
          meetDate = temp;
        } else {
          if (meetDate.isAfter(temp)) {
            meetDate = temp;
          }
        }
      }
    }
    if (meetDate == null) {
      return null;
    }
    return DateFormat('dd-MM-y').format(meetDate);
  }

  String? get lastMeeting {
    if (meetings.isEmpty) {
      return null;
    }
    var date = DateTime.now();
    DateTime? meetDate;
    for (var item in meetings) {
      if (item.year == null) {
        continue;
      }
      var temp = DateTime(item.year!, item.month, item.day);
      if (date.isAfter(temp)) {
        if (meetDate == null) {
          meetDate = temp;
        } else {
          if (meetDate.isBefore(temp)) {
            meetDate = temp;
          }
        }
      }
    }
    if (meetDate == null) {
      return null;
    }
    return DateFormat('dd-MM-y').format(meetDate);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/png/tabs/tab2_on.png',
            fit: BoxFit.fill,
          ),
        ),
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(6.h),
              Padding(
                padding: EdgeInsets.only(left: 153.w),
                child: Image.asset(
                  'assets/png/icons/calendar.png',
                  width: 35.w,
                  height: 35.h,
                  fit: BoxFit.contain,
                ),
              ),
              Gap(47.h),
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upcoming meetings',
                          style: AppStyles.helper7
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Gap(14.h),
                        buildContent(upcomingMeeting),
                        Gap(20.h),
                        Text(
                          'Last meeting',
                          style: AppStyles.helper7
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Gap(12.h),
                        buildContent(lastMeeting),
                      ],
                    ),
                    Gap(26.w),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _showDatePickerDialog,
                          child: Container(
                            width: 54.w,
                            height: 54.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.color1,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.15),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/png/icons/plus.png',
                              width: 32.w,
                              height: 32.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Gap(8.h),
                        Text(
                          'Create new',
                          style: AppStyles.helper7.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.blueAccent,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildContent(String? data) {
    if (data == null) {
      return Text(
        'empty',
        style: AppStyles.helper6,
      );
    }
    return Row(
      children: [
        Image.asset(
          'assets/png/icons/calendar.png',
          width: 24.w,
          height: 24.h,
          fit: BoxFit.contain,
          color: AppColors.grayAccent,
        ),
        Gap(10.w),
        Text(
          data,
          style: AppStyles.helper6.copyWith(color: AppColors.gray),
        ),
      ],
    );
  }

  void _showDatePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDatePickerDialog(
          initDate: DateTime.now(),
          onSet: _onSet,
        );
      },
    );
  }

  void _onSet(DateTime dateTime) {
    final name = widget.contact.displayName;
    final event = Event(
      month: dateTime.month,
      day: dateTime.day,
      year: dateTime.year,
      label: EventLabel.custom,
      customLabel: 'Meeting with $name',
    );
    widget.contact.events.add(event);
    widget.contact.update();
    setState(() {});
  }
}
