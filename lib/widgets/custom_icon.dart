import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 152.r,
      height: 40.r,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              'assets/png/contact.png',
              fit: BoxFit.cover,
            ),
            width: 40.r,
            height: 40.r,
          ),
          _buildIcon(left: 26.r),
          _buildIcon(left: 54.r),
          _buildIcon(left: 82.r),
          _buildIcon(left: 110.r)
        ],
      ),
    );
  }

  Widget _buildIcon({required double left}) {
    return Positioned(
      left: left,
      top: 0,
      width: 42.r,
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
            child: Image.asset(
              'assets/png/contact.png',
              fit: BoxFit.cover,
              width: 40.r,
              height: 40.r,
            ),
          ),
        ],
      ),
    );
  }
}
