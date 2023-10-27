import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(dropdownMenuEntries: [
      DropdownMenuEntry(
        value: 'val',
        label: 'label',
      ),
    ]);
  }
}
