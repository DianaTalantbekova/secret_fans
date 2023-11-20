import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/folders_manager.dart';
import 'package:secret_fans/managers/premium_manager.dart';

import '../models/folder.dart';
import '../resources/resources.dart';
import '../widgets/widgets.dart';
import 'premium_screen.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  late final FoldersManager foldersManager = context.read();
  late final PremiumManager premiumManager = context.read();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Consumer<FoldersManager>(
          builder: (context, provider, child) {
            return Column(
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Folders',
                        style: AppStyles.helper4,
                      ),
                      GestureDetector(
                        onTap: _newFolderDialog,
                        child: Text(
                          'Create',
                          style: AppStyles.helper5.copyWith(fontSize: 16.r),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                if (provider.folders.isEmpty) ...[
                  SizedBox(height: 159.h),
                  Text(
                    'Here will be your\nfoldes',
                    style: AppStyles.helper8,
                    textAlign: TextAlign.center,
                  ),
                ] else ...[
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 28.w),
                      itemCount: provider.folders.length,
                      itemBuilder: (BuildContext context, int index) {
                        var folder = provider.folders[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: FolderWidget(
                            folder: folder,
                            onTap: () => _onFolderTap(folder),
                            onDelete: () => _deleteFolderDialog(folder),
                            onRename: () => _renameFolderDialog(folder),
                            onEdit: () => _editContacts(folder),
                            onMove: () => context
                                .go('/folders_screen/move_folder_screen'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _newFolderDialog() async {
    if (foldersManager.folders.length > 2 && !premiumManager.isPremium) {
      final route = MaterialPageRoute(builder: (BuildContext context) {
        return const PremiumScreen();
      });
      Navigator.of(context, rootNavigator: true).push(route);
      return;
    }

    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return TextFieldDialog(
          onCancelTap: context.pop,
          onOkTap: _createFolder,
          text: 'New folder name',
        );
      },
    );
  }

  Future<void> _renameFolderDialog(Folder folder) {
    return showDialog(
      useSafeArea: false,
      barrierColor: AppColors.gray.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return TextFieldDialog(
          onCancelTap: context.pop,
          onOkTap: (name) => _renameFolder(name, folder),
          value: folder.name,
          text: 'Edit folder name',
        );
      },
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
          onDeleteTap: () => foldersManager.removeToBin(folder),
          text: 'folder',
        );
      },
    );
  }

  void existsSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Folder with this name is exists!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _createFolder(String name) {
    if (foldersManager.names.contains(name)) {
      return existsSnackBar();
    }
    foldersManager.createFolder(name);
    context.go('/folders_screen/add_contacts');
  }

  void _onFolderTap(Folder folder) {
    foldersManager.folder = folder;
    context.go('/folders_screen/opened_folder_screen');
  }

  _renameFolder(String name, Folder folder) {
    if (name == folder.name) {
      return;
    }
    if (foldersManager.names.contains(name)) {
      return existsSnackBar();
    }
    foldersManager.renameFolder(name, folder);
  }

  void _editContacts(Folder folder) {
    foldersManager.folder = folder;
    context.go('/folders_screen/edit_contacts');
  }
}
