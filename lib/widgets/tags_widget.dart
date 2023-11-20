import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/tag_manager.dart';
import 'package:secret_fans/widgets/custom_button2.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';
import 'custom_button5.dart';
import 'text_field_dialog.dart';

class TagsWidget extends StatefulWidget {
  const TagsWidget({super.key, this.onChanges, required this.values});

  final Function(List<String> tags)? onChanges;
  final List<String> values;

  @override
  State<TagsWidget> createState() => _TagsWidgetState();
}

class _TagsWidgetState extends State<TagsWidget> {
  late final TagManager tagManager = context.read();
  late List<String> tags = widget.values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              alignment: Alignment.center,
              height: 48.h,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grayAccent),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Consumer<TagManager>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var item in tags)
                          Row(
                            children: [
                              CustomButton2(text: item),
                              SizedBox(width: 4.w),
                              GestureDetector(
                                onTap: () => _removeItem(item),
                                child: Image.asset(
                                  'assets/png/icons/close_sign.png',
                                  width: 24.w,
                                  height: 24.h,
                                ),
                              ),
                              SizedBox(width: 10.w),
                            ],
                          ),
                        PopupMenuButton(
                          offset: const Offset(-100, 0),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          itemBuilder: (BuildContext context) {
                            return [
                              ...List.generate(
                                provider.tags.length,
                                (index) {
                                  final tag = provider.tags[index];
                                  return PopupMenuItem(
                                    onTap: () => _addTag(tag),
                                    child: CustomButton2(
                                      text: tag,
                                    ),
                                  );
                                },
                              ),
                              PopupMenuItem(
                                child: CustomButton5(
                                  onTap: _newTagNameDialog,
                                ),
                              ),
                            ];
                          },
                          child: Container(
                            color: Colors.transparent,
                            width: 250,
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
                'Tags',
                style: AppStyles.helper5.copyWith(fontSize: 12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _newTagNameDialog() {
    context.pop();
    showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return TextFieldDialog(
          onCancelTap: context.pop,
          onOkTap: (String name) {
            tagManager.create(name);
            _addTag(name);
          },
          text: 'New tag name',
        );
      },
    );
  }

  void _addTag(String tag) {
    setState(() {
      tags.add(tag);
    });
    widget.onChanges?.call(tags);
  }

  void _removeItem(String item) {
    setState(() {
      tags.remove(item);
    });
    widget.onChanges?.call(tags);
  }
}
