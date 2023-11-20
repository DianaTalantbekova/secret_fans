import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class CustomWheel<T> extends StatefulWidget {
  const CustomWheel({
    super.key,
    this.onChanged,
    required this.items,
    required this.translate,
    required this.value,
    this.canUpdate = false,
  });

  final void Function(T value)? onChanged;
  final List<T> items;
  final String Function(T value) translate;
  final T value;
  final bool canUpdate;

  @override
  State<CustomWheel> createState() => _CustomWheelState<T>();
}

class _CustomWheelState<T> extends State<CustomWheel<T>> {
  late int _selectedIndex = widget.items.indexOf(widget.value);

  @override
  void didUpdateWidget(covariant CustomWheel<T> oldWidget) {
    if (!widget.canUpdate) {
      return;
    }

    setState(() {
      _selectedIndex = widget.items.indexOf(widget.value);
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.grayAccent,
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  width: 80.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: AppColors.grayAccent,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: ListWheelScrollView(
              controller: FixedExtentScrollController(
                initialItem: _selectedIndex,
              ),
              itemExtent: 40.h,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: _onSelectedChange,
              useMagnifier: true,
              magnification: 1.2,
              diameterRatio: 10,
              perspective: 0.001,
              children: List.generate(
                widget.items.length,
                (index) => Center(
                  child: Text(
                    widget.translate(widget.items[index]),
                    textAlign: TextAlign.center,
                    style: AppStyles.helper5.copyWith(
                      color: _selectedIndex == index
                          ? AppColors.blueAccent
                          : AppColors.color1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSelectedChange(int value) {
    setState(() {
      _selectedIndex = value;
    });
    widget.onChanged?.call(widget.items[value]);
  }
}
