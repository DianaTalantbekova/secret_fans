import 'package:flutter/cupertino.dart';
import 'package:secret_fans/main.dart';

class PremiumManager extends ChangeNotifier {
  static const premiumKey = 'PREMIUM_KEY';

  bool isPremium = false;

  PremiumManager() {
    init();
  }

  void init() {
    isPremium = preferences.getBool(premiumKey) ?? false;
  }

  void buy() {
    isPremium = true;
    preferences.setBool(premiumKey, true);
    notifyListeners();
  }
}
