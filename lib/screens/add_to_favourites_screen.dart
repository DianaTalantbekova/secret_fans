import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/contacts_manager.dart';
import 'package:secret_fans/managers/favorite_manager.dart';
import 'package:secret_fans/managers/premium_manager.dart';

import '../resources/resources.dart';
import '../widgets/contact_info_widget.dart';
import '../widgets/widgets.dart';
import 'premium_screen.dart';

class AddToFavouritesScreen extends StatefulWidget {
  const AddToFavouritesScreen({super.key});

  @override
  State<AddToFavouritesScreen> createState() => _AddToFavouritesScreenState();
}

class _AddToFavouritesScreenState extends State<AddToFavouritesScreen> {
  late final FavoriteManager favoriteManager = context.read();
  late final PremiumManager premiumManager = context.read();
  List<Contact> contacts = [];
  late List<Contact> addedContacts = favoriteManager.favContacts;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer<ContactsManager>(
          builder: (context, provider, child) {
            return Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Image.asset(
                          'assets/png/icons/back.png',
                          fit: BoxFit.contain,
                          width: 28.w,
                          height: 28.h,
                        ),
                      ),
                      SizedBox(width: 26.w),
                      Text(
                        'Choose a contact',
                        style: AppStyles.helper4,
                      ),
                      const Spacer(),
                      SaveButton(
                        onTap: _onSave,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.length,
                    itemBuilder: (BuildContext context, int index) {
                      final contact = provider.sortedContacts[index];
                      final selected = contacts.contains(contact);
                      final canRemove = addedContacts.contains(contact);
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ContactInfoWidget(
                          contact: contact,
                          showLetter: provider.showLetter(contact),
                          searchText: provider.searchText,
                          onTap: () => _onTap(selected, canRemove, contact),
                          suffixIcon: _buildIcon(
                            selected: selected,
                            canRemove: canRemove,
                          ),
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

  Widget _buildIcon({
    bool selected = false,
    bool canRemove = false,
  }) {
    if (selected) {
      return Image.asset(
        'assets/png/icons/check.png',
        fit: BoxFit.contain,
        width: 24.w,
        height: 24.h,
      );
    }
    if (canRemove) {
      return Image.asset(
        'assets/png/icons/close_sign.png',
        fit: BoxFit.contain,
        width: 24.w,
        height: 24.h,
      );
    }
    return const SizedBox();
  }

  void _onTap(bool selected, bool canRemove, Contact contact) {
    if (canRemove) {
      setState(() {
        addedContacts.remove(contact);
      });
      return;
    }
    if (selected) {
      setState(() {
        contacts.remove(contact);
      });
      return;
    }

    var l1 = contacts.length;
    var l2 = addedContacts.length;
    if ((l1 + l2) > 2 && !premiumManager.isPremium) {
      final route = MaterialPageRoute(builder: (BuildContext context) {
        return const PremiumScreen();
      });
      Navigator.of(context, rootNavigator: true).push(route);
      return;
    }

    setState(() {
      contacts.add(contact);
    });
  }

  void _onSave() {
    contacts.addAll(addedContacts);
    favoriteManager.addFavorites(contacts);
    context.pop();
  }
}
