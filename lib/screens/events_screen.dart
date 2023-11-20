import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/contacts_manager.dart';
import 'package:secret_fans/widgets/event_widget.dart';

import '../resources/app_styles.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: context.pop,
                        child: Image.asset(
                          'assets/png/icons/back.png',
                          width: 32.w,
                          height: 32.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        'Events',
                        style: AppStyles.helper4,
                      ),
                      Gap(32.w),
                    ],
                  ),
                ),
                Gap(15.h),
                if (provider.contactsWithEvents.isEmpty) ...[
                  Expanded(
                    child: Center(
                      child: Text(
                        'No recents',
                        style: AppStyles.helper8,
                      ),
                    ),
                  ),
                ] else
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.contactsWithEvents.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 24.w,
                        ),
                        child: EventWidget(
                          contact: provider.contactsWithEvents[index],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
