import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:intl/intl.dart';
import 'package:secret_fans/main.dart';
import 'package:secret_fans/managers/contacts_manager.dart';

class RecentManager extends ChangeNotifier {
  static const recentKey = 'RECENT_KEY';
  static const datesKey = 'DATES_KEY';

  final ContactsManager contactsManager;

  List<String> ids = [];
  List<DateTime> dates = [];

  List<Contact> recentList = [];

  List<Contact> get firstThree => recentList.take(3).toList();

  List<Contact> get contacts => contactsManager.contacts;

  RecentManager({required this.contactsManager});

  void init() async {
    ids = preferences.getStringList(recentKey) ?? [];
    var data = preferences.getStringList(datesKey) ?? [];

    for (var id in ids) {
      var contact = contacts.firstWhere((element) => element.id == id,
          orElse: () => Contact(id: 'RR'));

      if(contact.id == 'RR'){
        continue;
      }

      recentList.add(contact);
    }

    dates = data.map((e) => DateTime.parse(e)).toList();
    notifyListeners();
  }

  void call(Contact contact) {
    dates.insert(0, DateTime.now());
    recentList.insert(0, contact);
    ids.insert(0, contact.id);
    notifyListeners();

    var stringDates = dates.map((e) => e.toIso8601String()).toList();
    preferences.setStringList(recentKey, ids);
    preferences.setStringList(datesKey, stringDates);
  }
}
