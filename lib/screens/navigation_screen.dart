import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../models/image_item.dart';
import '../resources/resources.dart';
import '../utils/utils.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({
    Key? key,
    required this.child,
    // required this.preferenceService,
  }) : super(key: key);
  final Widget child;

  // final PreferenceService preferenceService;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selected = 0;

  // @override
  // void initState() {
  // final hasPremium = widget.preferenceService.isPremium();
  // if (!hasPremium) {
  //   Future.delayed(Duration(milliseconds: 500), () => _buyPremium(context));
  // }
  // super.initState();
  // }

  // _buyPremium(BuildContext context) {
  //   final route = MaterialPageRoute(
  //     builder: (BuildContext context) => PremiumScreen(
  //       profileBloc: BlocProvider.of(context),
  //     ),
  //   );
  //   Navigator.of(context, rootNavigator: true).push(route);
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(child: widget.child),
            SizedBox(
              height: 56.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imageItems.length,
                  (index) {
                    final item = imageItems[index];
                    return _buildNavigationBarItem(
                      imageItem: item,
                      selected: index == _selected,
                      onTap: () {
                        _selected = index;
                        context.go(item.path);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationBarItem({
    required ImageItem imageItem,
    bool selected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 68.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selected ? AppColors.lightestBlue : Colors.transparent,
        ),
        child: Center(
          child: SizedBox(
            width: 36.w,
            height: 36.w,
            child: Image.asset(
              imageItem.asset,
              fit: BoxFit.cover,
              color: selected ? AppColors.blueAccent : AppColors.grayAccent,
            ),
          ),
        ),
      ),
    );
  }
}
