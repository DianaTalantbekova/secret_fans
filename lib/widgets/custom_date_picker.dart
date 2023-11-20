import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:secret_fans/widgets/custom_date_picker_dialog.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.title,
    this.dateTime,
    this.onChange,
  });

  final String title;
  final DateTime? dateTime;
  final Function(DateTime dateTime)? onChange;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime? dateTime = widget.dateTime;

  String get parseDate {
    if (dateTime == null) return '';
    return DateFormat('dd-MM-y').format(dateTime!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDialog,
      child: SizedBox(
        width: 254.w,
        height: 56.h,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.centerLeft,
                height: 48.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grayAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  parseDate,
                  style: AppStyles.helper7.copyWith(fontSize: 18.r),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 14.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                color: Colors.white,
                child: Text(
                  widget.title,
                  style: AppStyles.helper5.copyWith(fontSize: 12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDatePickerDialog(
          initDate: dateTime,
          onSet: _onSet,
        );
      },
    );
  }

  void _onSet(DateTime dateTime) {
    setState(() {
      this.dateTime = dateTime;
    });
    widget.onChange?.call(dateTime);
  }
}
