import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secret_fans/widgets/custom_avatar.dart';

class CustomIcon extends StatefulWidget {
  const CustomIcon({super.key, required this.contacts});

  final List<Contact> contacts;

  @override
  State<CustomIcon> createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  List<double> stops = [0, 26.r, 54.r, 82.r, 110.r];

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return SizedBox(
      width: 152.r,
      height: 40.r,
      child: Stack(
        children: widget.contacts
            .take(5)
            .map((e) => _buildIcon(
                  left: stops[index],
                  isFirst: index == 0,
                  data: widget.contacts[index++].photoOrThumbnail,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildIcon({
    required double left,
    bool isFirst = false,
    required Uint8List? data,
  }) {
    return Positioned(
      left: left,
      top: 0,
      width: isFirst ? 40.r : 42.r,
      height: 40.r,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 40.r,
              height: 40.r,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: CustomAvatar(
              data: data,
              radius: 20.r,
            ),
          ),
        ],
      ),
    );
  }
}
