import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/contacts_manager.dart';
import 'package:secret_fans/managers/tag_manager.dart';
import 'package:secret_fans/widgets/custom_avatar.dart';
import 'package:secret_fans/widgets/custom_date_picker.dart';
import 'package:secret_fans/widgets/tags_widget.dart';

import '../resources/resources.dart';
import '../widgets/widgets.dart';

class CreateNewContact extends StatefulWidget {
  const CreateNewContact({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  State<CreateNewContact> createState() => _CreateNewContactState();
}

class _CreateNewContactState extends State<CreateNewContact> {
  late final ContactsManager contactsManager = context.read();
  late final TagManager tagManager = context.read();
  late final nameController =
      TextEditingController(text: contactsManager.contact?.name.first);
  late final surnameController =
      TextEditingController(text: contactsManager.contact?.name.last);
  late final numberController = TextEditingController(
      text: contactsManager.contact?.phones.firstOrNull?.number);
  late DateTime? dateTime = parseDate();
  late List<String> tags = tagManager.getTagsForId(contactsManager.contact?.id);

  DateTime? parseDate() {
    var events = contactsManager.contact?.events
        .where((element) => element.label == EventLabel.birthday)
        .toList();
    if (events?.isEmpty ?? false) {
      return null;
    }
    var event = events!.first;
    if (event.year == null) {
      return null;
    }
    var date = DateTime(event.year!, event.month, event.day);

    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Gap(16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: context.pop,
                      child: Image.asset(
                        'assets/png/icons/back.png',
                        fit: BoxFit.contain,
                        width: 28.w,
                        height: 28.h,
                      ),
                    ),
                    widget.isEdit
                        ? GestureDetector(
                            onTap: _deleteContactDialog,
                            child: Image.asset(
                              'assets/png/icons/bin.png',
                              fit: BoxFit.contain,
                              width: 36.w,
                              height: 36.h,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              CustomAvatar(
                data: contactsManager.contact?.photoOrThumbnail,
                radius: 80.r,
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: _onLoadPhoto,
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/png/icons/edit.png',
                        fit: BoxFit.contain,
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        contactsManager.contact?.photoOrThumbnail == null
                            ? 'Upload photo'
                            : 'Change photo',
                        style: AppStyles.helper5.copyWith(fontSize: 16.r),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/icons/contact_icon.png',
                      fit: BoxFit.contain,
                      width: 28.w,
                      height: 28.h,
                    ),
                    SizedBox(width: 16.w),
                    ProfileTextField(
                      title: 'Name',
                      controller: nameController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              ProfileTextField(
                title: 'Surname',
                controller: surnameController,
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/icons/call.png',
                      fit: BoxFit.contain,
                      width: 28.w,
                      height: 28.h,
                    ),
                    SizedBox(width: 16.w),
                    ProfileTextField(
                      title: 'Number',
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/icons/birthday.png',
                      fit: BoxFit.contain,
                      width: 28.w,
                      height: 28.h,
                    ),
                    SizedBox(width: 16.w),
                    CustomDatePicker(
                      dateTime: dateTime,
                      title: 'Birthday',
                      onChange: (dateTime) => this.dateTime = dateTime,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/icons/tag.png',
                      fit: BoxFit.contain,
                      width: 28.w,
                      height: 28.h,
                      color: AppColors.lightBlue,
                    ),
                    SizedBox(width: 16.w),
                    TagsWidget(
                      onChanges: _onTagsChange,
                      values: tags,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              SaveButton(
                onTap: _onSave,
                width: 174.w,
                height: 48.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteContactDialog() {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          onCancelTap: context.pop,
          onDeleteTap: _onDelete,
          text: 'contact',
        );
      },
    );
  }

  void fillContact() {
    contactsManager.contact!.name.first = nameController.text.trim();
    contactsManager.contact!.name.last = surnameController.text.trim();
    final phone = Phone(numberController.text.trim());
    if (contactsManager.contact!.phones.isEmpty) {
      contactsManager.contact!.phones.add(phone);
    } else {
      contactsManager.contact!.phones.removeAt(0);
      contactsManager.contact!.phones.insert(0, phone);
    }

    if (dateTime != null) {
      final event = Event(
        month: dateTime!.month,
        day: dateTime!.day,
        year: dateTime!.year,
        label: EventLabel.birthday,
      );

      var index = contactsManager.contact!.events
          .indexWhere((element) => element.label == EventLabel.birthday);
      if (index == -1) {
        contactsManager.contact!.events.add(event);
      } else {
        contactsManager.contact!.events.removeAt(index);
        contactsManager.contact!.events.insert(index, event);
      }
    }
  }

  void _onSave() async {
    if (contactsManager.contact == null) {
      return;
    }

    fillContact();
    if (widget.isEdit) {
      await contactsManager.update();
    } else {
      await contactsManager.create();
    }

    tagManager.addTagsForId(contactsManager.contact!.id, tags);
    // ignore: use_build_context_synchronously
    context.pop();
  }

  void _onDelete() {
    contactsManager.deleteToBin();
    context
      ..pop()
      ..pop();
  }

  _onTagsChange(List<String> tags) {
    this.tags = tags;
  }

  void _onLoadPhoto() async {
    var xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) {
      return;
    }
    var readAsBytes = await xFile.readAsBytes();

    contactsManager.contact!.photo = readAsBytes;
    setState(() {});
  }
}
