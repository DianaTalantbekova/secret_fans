import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:secret_fans/main.dart';
import 'package:secret_fans/managers/contacts_manager.dart';

class FavoriteManager extends ChangeNotifier {
  static const favoritesKey = 'FAVORITES_KEY';

  final ContactsManager contactsManager;

  List<String> ids = [];
  List<Contact> favContacts = [];

  List<Contact> get _contacts => contactsManager.contacts;

  FavoriteManager({required this.contactsManager}) {
    init();
  }

  void init() {
    ids = preferences.getStringList(favoritesKey) ?? [];
    favContacts =
        _contacts.where((element) => ids.contains(element.id)).toList();
    notifyListeners();
  }

  void addFavorites(List<Contact> contacts) {
    favContacts = contacts;
    save();
    notifyListeners();
  }

  void save() {
    ids = favContacts.map((e) => e.id).toList();
    preferences.setStringList(favoritesKey, ids);
  }

  void setFavorite(Contact contact) {
    if (favContacts.contains(contact)) {
      favContacts.remove(contact);
    } else {
      favContacts.add(contact);
    }
    save();
    notifyListeners();
  }
}
