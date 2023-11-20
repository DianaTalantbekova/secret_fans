import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/main.dart';
import 'package:secret_fans/managers/contacts_manager.dart';
import 'package:uuid/uuid.dart';

import '../resources/app_colors.dart';

class ImagesTab extends StatefulWidget {
  const ImagesTab({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  State<ImagesTab> createState() => _ImagesTabState();
}

class _ImagesTabState extends State<ImagesTab> {
  static const imageKey = 'IMAGE_KEY';
  late final ContactsManager contactsManager = context.read();
  List<String> imagePaths = [];

  String get id => widget.contact.id;

  String get imagesKey => '$imageKey$id';

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    imagePaths = preferences.getStringList(imagesKey) ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/png/tabs/tab3_on.png',
            fit: BoxFit.fill,
          ),
        ),
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(6.h),
              Padding(
                padding: EdgeInsets.only(left: 267.w),
                child: Image.asset(
                  'assets/png/icons/photo.png',
                  width: 35.w,
                  height: 35.h,
                  fit: BoxFit.contain,
                ),
              ),
              Gap(25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  height: 214.h,
                  width: 302.w,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 19.w,
                        runSpacing: 19.h,
                        children: [
                          if (widget.contact.photoOrThumbnail != null)
                            GestureDetector(
                              onTap: () => _showImage(
                                imageProvider: Image.memory(
                                        widget.contact.photoOrThumbnail!)
                                    .image,
                                isMain: true,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(
                                  widget.contact.photoOrThumbnail!,
                                  width: 88.w,
                                  height: 88.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          for (int i = 0; i < imagePaths.length; i++)
                            GestureDetector(
                              onTap: () => _showImage(
                                imageProvider:
                                    Image.file(File(imagePaths[i])).image,
                                index: i,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(imagePaths[i]),
                                  width: 88.w,
                                  height: 88.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          GestureDetector(
                            onTap: _onAdd,
                            child: DottedBorder(
                              radius: const Radius.circular(12),
                              borderType: BorderType.RRect,
                              dashPattern: const [2, 2],
                              color: AppColors.grayAccent,
                              child: SizedBox(
                                width: 83.w,
                                height: 83.h,
                                child: Center(
                                  child: Image.asset(
                                    'assets/png/icons/plus.png',
                                    width: 36.w,
                                    height: 36.h,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onAdd() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) {
      return;
    }

    if (widget.contact.photoOrThumbnail == null) {
      var readAsBytes = await xFile.readAsBytes();
      widget.contact.photo = readAsBytes;
      // await widget.contact.update();
      contactsManager.update();
    } else {
      final file = File(xFile.path);
      final directory = await getApplicationDocumentsDirectory();
      final imageName = const Uuid().v4();
      final newImage = await file.copy('${directory.path}/$imageName');

      imagePaths.add(newImage.path);
      preferences.setStringList(imagesKey, imagePaths);
      setState(() {});
    }
  }

  void _showImage({
    required ImageProvider imageProvider,
    bool isMain = false,
    int index = 0,
  }) {
    showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              width: 314.w,
              height: 560.h,
              decoration: BoxDecoration(
                color: AppColors.lightestBlue,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 2),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(16.h),
            Opacity(
              opacity: 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: context.pop,
                    child: Image.asset(
                      'assets/png/icons/close.png',
                      width: 36.w,
                      height: 36.h,
                      color: AppColors.color2,
                    ),
                  ),
                  Gap(32.w),
                  GestureDetector(
                    onTap: () => _onRemove(isMain, index),
                    child: Image.asset(
                      'assets/png/icons/bin.png',
                      width: 36.w,
                      height: 36.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _onRemove(bool isMain, int index) async {
    context.pop();
    if (isMain) {
      Uint8List? data;
      if (imagePaths.isNotEmpty) {
        final file = File(imagePaths.first);
        data = await file.readAsBytes();
        imagePaths.removeAt(0);
        preferences.setStringList(imagesKey, imagePaths);
        setState(() {});
      }
      widget.contact.photo = data;
      contactsManager.update();
    } else {
      if (imagePaths.length <= index) {
        return;
      }

      imagePaths.removeAt(index);

      preferences.setStringList(imagesKey, imagePaths);
      setState(() {});
    }
  }
}
