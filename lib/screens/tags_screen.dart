import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/tag_manager.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  late final TagManager tagManager = context.read();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer<TagManager>(
          builder: (context, provider, child) {
            return Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => context.pop(),
                            child: Image.asset(
                              'assets/png/icons/back.png',
                              fit: BoxFit.contain,
                              width: 28.w,
                              height: 28.h,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Tags',
                            style: AppStyles.helper4,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _newTagNameDialog,
                            child: Text(
                              'Add',
                              style: AppStyles.helper5.copyWith(fontSize: 18.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (provider.tags.isEmpty) ...[
                  SizedBox(height: 263.h),
                  Text(
                    'Here will be your\ntags',
                    style: AppStyles.helper8,
                    textAlign: TextAlign.center,
                  ),
                ],
                SizedBox(height: 42.h),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 16.w,
                          runSpacing: 16.h,
                          children: provider.tags
                              .map(
                                (e) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomButton2(text: e),
                                    SizedBox(width: 4.w),
                                    GestureDetector(
                                      onTap: () => _deleteTagDialog(e),
                                      child: Image.asset(
                                        'assets/png/icons/close.png',
                                        fit: BoxFit.contain,
                                        width: 22.w,
                                        height: 22.h,
                                        color: AppColors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _newTagNameDialog() {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return TextFieldDialog(
          onCancelTap: context.pop,
          onOkTap: _onCreate,
          text: 'New tag name',
        );
      },
    );
  }

  Future<void> _deleteTagDialog(String tag) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          onCancelTap: context.pop,
          onDeleteTap: () => tagManager.remove(tag),
          text: 'tag',
        );
      },
    );
  }

  void existsSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tag with this name is exists!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _onCreate(String name) {
    if (tagManager.tags.contains(name)) {
      return existsSnackBar();
    }
    tagManager.create(name);
  }
}
