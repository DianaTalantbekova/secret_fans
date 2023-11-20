import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';
import '../screens/custom_wheel.dart';

class CustomDatePickerDialog extends StatefulWidget {
  const CustomDatePickerDialog({
    super.key,
    required this.initDate,
    this.onSet,
  });

  final DateTime? initDate;
  final void Function(DateTime dateTime)? onSet;

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  late DateTime dateTime = widget.initDate ?? DateTime.now();
  late final int year = dateTime.year;
  List<int> days = [];
  List<int> months = [for (int i = 1; i <= 12; i++) i];
  late List<int> years = [for (int i = year - 50; i <= year; i++) i];

  late int selectedDay = dateTime.day;
  late int selectedMonth = dateTime.month;
  late int selectedYear = dateTime.year;

  @override
  void initState() {
    _calculate();
    super.initState();
  }

  void _calculate() {
    final int daysInMonth = DateUtils.getDaysInMonth(
      selectedYear,
      selectedMonth,
    );

    if (daysInMonth < selectedDay) {
      selectedDay = daysInMonth;
      setState(() {});
    }

    days = [for (int i = 1; i <= daysInMonth; i++) i];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 302.w,
        height: 248.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 16.h,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select a date',
                style: AppStyles.helper5.copyWith(color: AppColors.gray),
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomWheel<int>(
                    items: days,
                    translate: (int value) => value.toString(),
                    value: selectedDay,
                    onChanged: _onChangeDay,
                    canUpdate: true,
                  ),
                  CustomWheel<int>(
                    items: months,
                    translate: (int value) => DateFormat('MMM').format(
                      DateTime.now().copyWith(month: value),
                    ),
                    onChanged: _onMonthChanged,
                    value: selectedMonth,
                  ),
                  CustomWheel<int>(
                    items: years,
                    translate: (int value) => value.toString(),
                    value: selectedYear,
                    onChanged: _onYearChanged,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: context.pop,
                  child: Text(
                    'Cancel',
                    style:
                        AppStyles.helper5.copyWith(color: AppColors.blueAccent),
                  ),
                ),
                SizedBox(width: 20.w),
                GestureDetector(
                  onTap: _onSet,
                  child: Text(
                    'Set',
                    style:
                        AppStyles.helper5.copyWith(color: AppColors.blueAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onMonthChanged(int value) {
    selectedMonth = value;
    _calculate();
    setState(() {});
  }

  void _onYearChanged(int value) {
    selectedYear = value;
    _calculate();
    setState(() {});
  }

  void _onChangeDay(int value) {
    selectedDay = value;
  }

  void _onSet() {
    final dateTime = DateTime(selectedYear, selectedMonth, selectedDay);
    widget.onSet?.call(dateTime);
    context.pop();
  }
}
