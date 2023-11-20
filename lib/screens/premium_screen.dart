import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../managers/premium_manager.dart';
import '../resources/resources.dart';
import '../utils/links.dart';
import '../widgets/widgets.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            'assets/png/icons/back.png',
                            fit: BoxFit.contain,
                            width: 28.w,
                            height: 28.h,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'Premium',
                          style: AppStyles.helper4,
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox.shrink()),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Image.asset(
                'assets/png/premium.png',
                fit: BoxFit.contain,
                width: 303.w,
                height: 303.h,
              ),
              SizedBox(height: 19.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/png/icons/favorite_icon.png',
                    fit: BoxFit.contain,
                    width: 36.w,
                    height: 36.h,
                    color: AppColors.blueAccent,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Unlimited favorites\nand folders',
                    style: AppStyles.helper4.copyWith(fontSize: 24.r),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/png/icons/no_ads.png',
                    fit: BoxFit.contain,
                    width: 36.w,
                    height: 36.h,
                    color: AppColors.blueAccent,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Without ads',
                    style: AppStyles.helper4.copyWith(fontSize: 24.r),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              SaveButton(
                onTap: _onBuyPremium,
                width: 228.w,
                height: 48.h,
                text: 'Buy for \$0.99',
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _onRestore,
                    child: Text(
                      'Restore',
                      style: AppStyles.helper10,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    width: 1.w,
                    height: 16.h,
                    color: AppColors.grayAccent,
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () => launchUri(Links.termsOfUse),
                    child: Text(
                      'Terms of Use',
                      style: AppStyles.helper10,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    width: 1.w,
                    height: 16.h,
                    color: AppColors.grayAccent,
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () => launchUri(Links.privacyPolicy),
                    child: Text(
                      'Privacy Policy',
                      style: AppStyles.helper10,
                    ),
                  ),
                  SizedBox(width: 12.w),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  void _onRestore() async {
    final provider = Provider.of<PremiumManager>(context, listen: false);
    final res = await Apphud.restorePurchases();
    if (res.purchases.map((e) => e.isActive).contains(true)) {
      provider.buy();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  void _onBuyPremium() async {
    final provider = Provider.of<PremiumManager>(context, listen: false);
    var paywalls = await Apphud.paywalls();

    await Apphud.purchase(
      product: paywalls?.paywalls.first.products!.first,
    ).whenComplete(
      () async {
        if (await Apphud.hasActiveSubscription() ||
            await Apphud.hasPremiumAccess()) {
          provider.buy();
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      },
    );
  }
}
