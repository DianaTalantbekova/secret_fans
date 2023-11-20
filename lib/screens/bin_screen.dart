import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/contacts_manager.dart';
import 'package:secret_fans/managers/folders_manager.dart';
import 'package:secret_fans/widgets/bin_contact.dart';
import 'package:secret_fans/widgets/bin_folder.dart';

import '../models/folder.dart';
import '../resources/resources.dart';
import '../widgets/widgets.dart';

class BinScreen extends StatefulWidget {
  const BinScreen({super.key});

  @override
  State<BinScreen> createState() => _BinScreenState();
}

class _BinScreenState extends State<BinScreen> {
  late final FoldersManager foldersManager = context.read();
  late final ContactsManager contactsManager = context.read();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer2<ContactsManager, FoldersManager>(
          builder: (context, provider, provider2, child) {
            final empty =
                provider.deletedIds.isEmpty && provider2.deletedIds.isEmpty;
            return Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => context.pop(),
                            child: Image.asset(
                              'assets/png/icons/back.png',
                              fit: BoxFit.contain,
                              width: 32.w,
                              height: 32.h,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            'Bin',
                            style: AppStyles.helper4,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                    ],
                  ),
                ),
                if (empty) ...[
                  SizedBox(height: 265.h),
                  Text(
                    'Bin is empty',
                    style: AppStyles.helper8,
                    textAlign: TextAlign.center,
                  ),
                ],
                SizedBox(height: 16.h),
                ...provider.deletedContacts
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: BinContact(
                          contact: e,
                          onTap: () => _deleteContactDialog(e),
                        ),
                      ),
                    )
                    .toList(),
                ...provider2.deletedFolders
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: BinFolder(
                          folder: e,
                          onTap: () => _deleteFolderDialog(e),
                        ),
                      ),
                    )
                    .toList(),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteFolderDialog(Folder folder) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          onCancelTap: context.pop,
          onDeleteTap: () => foldersManager.removeFolder(folder),
          text: 'permanently',
        );
      },
    );
  }

  Future<void> _deleteContactDialog(Contact contact) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          onCancelTap: context.pop,
          onDeleteTap: () => contactsManager.delete(contact),
          text: 'permanently',
        );
      },
    );
  }
}
