import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/tag_manager.dart';
import 'package:secret_fans/widgets/custom_button5.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';
import 'custom_button2.dart';
import 'text_field_dialog.dart';

class InfoTab extends StatefulWidget {
  const InfoTab({super.key, required this.contact});

  final Contact contact;

  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  late final TagManager tagManager = context.read();

  List<String> get tags => tagManager.getTagsForId(widget.contact.id);

  String? get parseDate {
    var birthdayEvent = widget.contact.events.firstWhere(
      (e) => e.label == EventLabel.birthday,
      orElse: () => Event(month: 12, day: 12, label: EventLabel.other),
    );

    if (birthdayEvent.label != EventLabel.birthday) {
      return null;
    }

    return DateFormat('dd-MM-y').format(
        DateTime(birthdayEvent.year!, birthdayEvent.month, birthdayEvent.day));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/png/tabs/tab1_on.png',
            fit: BoxFit.fill,
          ),
        ),
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(6.h),
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: Image.asset(
                  'assets/png/icons/info.png',
                  width: 35.w,
                  height: 35.h,
                  fit: BoxFit.contain,
                ),
              ),
              Gap(39.h),
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact info',
                      style: AppStyles.helper7
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Gap(8.h),
                    _buildContent(
                      widget.contact.phones.isEmpty
                          ? null
                          : widget.contact.phones.first.number,
                      'assets/png/icons/call.png',
                    ),
                    Gap(12.h),
                    Text(
                      'Birthday',
                      style: AppStyles.helper7
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Gap(8.h),
                    _buildContent(
                      parseDate,
                      'assets/png/icons/birthday.png',
                    ),
                    Gap(12.h),
                    Text(
                      'Tags',
                      style: AppStyles.helper7
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Gap(8.h),
                  ],
                ),
              ),
              Consumer<TagManager>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        for (int i = 0; i < tags.length; i++)
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: CustomButton2(text: tags[i]),
                          ),
                        PopupMenuButton(
                          // offset: const Offset(-100, 0),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 10.h,
                          ),
                          // position: PopupMenuPosition.over,
                          itemBuilder: (BuildContext context) {
                            return [
                              ...List.generate(
                                provider.tags.length,
                                (index) {
                                  var tag = provider.tags[index];
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
                          child: Image.asset(
                            'assets/png/icons/plus.png',
                            width: 30.w,
                            height: 30.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
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

  Widget _buildContent(String? data, String asset) {
    if (data == null) {
      return Text(
        'empty',
        style: AppStyles.helper6,
      );
    }

    return Row(
      children: [
        Image.asset(
          'assets/png/icons/birthday.png',
          width: 24.w,
          height: 24.h,
          fit: BoxFit.contain,
          color: AppColors.grayAccent,
        ),
        Gap(8.w),
        Text(
          data,
          style: AppStyles.helper6.copyWith(color: AppColors.gray),
        ),
      ],
    );
  }

  void _addTag(String tag) => tagManager.addTagForId(tag, widget.contact.id);
}
