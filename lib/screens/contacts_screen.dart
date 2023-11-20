import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/main.dart';
import 'package:secret_fans/managers/contacts_manager.dart';
import 'package:secret_fans/managers/favorite_manager.dart';
import 'package:secret_fans/managers/tag_manager.dart';
import 'package:secret_fans/widgets/contact_info_widget.dart';
import 'package:secret_fans/widgets/custom_button4.dart';

import '../resources/app_styles.dart';
import '../widgets/widgets.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer2<ContactsManager, FavoriteManager>(
          builder: (context, provider, provider2, child) {
            return Column(
              children: [
                SizedBox(height: 20.h),
                TextFieldWidget(
                  controller: provider.textController,
                  onClearTap: provider.clearText,
                ),
                if (!provider.isSearching) ...[
                  SizedBox(height: 16.h),
                  _buildTags(),
                  SizedBox(height: 16.h),
                  CustomButton4(
                    onTap: () {
                      contactsManager.contact = Contact();
                      context.go('/contacts_screen/create_new_contact');
                    },
                  ),
                  if (provider.isEmpty) ...[
                    SizedBox(height: 205.h),
                    GestureDetector(
                      onTap: () {
                        provider.getAll();
                      },
                      child: Text(
                        'Here will be your\ncontacts',
                        style: AppStyles.helper8,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ],
                SizedBox(height: 16.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.length,
                    itemBuilder: (BuildContext context, int index) {
                      final contact = provider.sortedContacts[index];
                      final isFavorite = provider2.ids.contains(contact.id);
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ContactInfoWidget(
                          isFavorite: isFavorite,
                          contact: contact,
                          showLetter: provider.showLetter(contact),
                          searchText: provider.searchText,
                          onTap: () {
                            provider.contact = contact;
                            context.go('/contacts_screen/contact_info');
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTags() {
    return Consumer<TagManager>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: provider.tags
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: CustomButton2(
                      onTap: () => provider.select(e),
                      text: e,
                      selected: e == provider.selected,
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
