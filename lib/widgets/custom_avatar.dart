import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key, required this.data, this.radius});

  final Uint8List? data;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: (radius ?? 30.r) * 2,
        height: (radius ?? 30.r) * 2,
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (data == null) {
      return Image.asset(
        'assets/png/without_photo.png',
        fit: BoxFit.cover,
      );
    }
    return Image.memory(
      data!,
      fit: BoxFit.cover,
    );
  }

}
