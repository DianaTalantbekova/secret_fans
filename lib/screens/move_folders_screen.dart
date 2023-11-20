import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/folders_manager.dart';

import '../models/folder.dart';
import '../resources/resources.dart';
import '../widgets/widgets.dart';

class MoveFoldersScreen extends StatefulWidget {
  const MoveFoldersScreen({super.key});

  @override
  State<MoveFoldersScreen> createState() => _MoveFoldersScreenState();
}

class _MoveFoldersScreenState extends State<MoveFoldersScreen> {
  late final FoldersManager foldersManager = context.read();

  late List<Folder> folders = foldersManager.folders;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
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
                  SizedBox(width: 26.w),
                  Text(
                    'Move folders',
                    style: AppStyles.helper4,
                  ),
                  const Spacer(),
                  SaveButton(
                    onTap: _onSave,
                  )
                ],
              ),
            ),
            SizedBox(height: 28.h),
            Expanded(
              child: ReorderableListView.builder(
                itemCount: folders.length,
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                onReorder: onReorder,
                itemBuilder: (BuildContext context, int index) {
                  final folder = folders[index];
                  return Padding(
                    key: ValueKey(folder.name),
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: FolderWidget(
                      folder: folder,
                      isMenu: false,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = folders.removeAt(oldIndex);
      folders.insert(newIndex, item);
    });
  }

  void _onSave() {
    foldersManager.reorder(folders);
    context.pop();
  }
}
