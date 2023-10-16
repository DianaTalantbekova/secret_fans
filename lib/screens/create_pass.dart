import 'package:flutter/material.dart';
import 'package:secret_fans/resources/app_styles.dart';

class CreatePass extends StatelessWidget {
  const CreatePass({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                Text(
                  'Password',
                  style: AppStyles.helper4,
                ),
                Text(
                  'Skip',
                  style: AppStyles.helper5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
