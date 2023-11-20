import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:secret_fans/main.dart';

class ContactsManager extends ChangeNotifier {
  static const deletedIdsKey = 'DELETED_IDS_KEY';
  List<Contact> contacts = [];
  List<Contact> sortedContacts = [];
  List<String> deletedIds = [];
  Map<String, String> sortLetters = {};
  final TextEditingController textController = TextEditingController();
  Timer? _debounce;

  List<Contact> get contactsWithEvents =>
      contacts.where((element) => element.events.isNotEmpty).toList();

  List<Contact> get deletedContacts =>
      contacts.where((element) => deletedIds.contains(element.id)).toList();

  ContactsManager() {
    init();
    textController.addListener(_listener);
  }

  Contact? contact;

  bool hasTag = false;
  List<String> tagIds = [];

  bool get isEmpty => sortedContacts.isEmpty;

  int get length => sortedContacts.length;

  bool get isSearching => searchText.isNotEmpty;

  String get searchText => textController.text;

  void init() {
    deletedIds = preferences.getStringList(deletedIdsKey) ?? [];
  }

  void save() {
    preferences.setStringList(deletedIdsKey, deletedIds);
  }

  void permanentlyClear() {
    preferences.setStringList(deletedIdsKey, []);
  }

  Future<void> getAll() async {
    contacts = await FlutterContacts.getContacts(
      withAccounts: true,
      withGroups: true,
      withPhoto: true,
      withProperties: true,
      withThumbnail: true,
    );

    for (var i = 0; i < contacts.length; ++i) {
      var contact = contacts[i];
      var letter = contact.displayName[0];
      if (sortLetters[letter] == null) {
        sortLetters[letter] = contact.id;
      }
    }

    _search();

    notifyListeners();
  }

  bool showLetter(Contact contact) {
    var letter = contact.displayName[0];
    return sortLetters[letter] == contact.id;
  }

  void clearText() {
    textController.clear();
    _search();
  }

  void _listener() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), _search);
  }

  void _search() {
    if (isSearching) {
      sortedContacts = contacts
          .where((element) =>
              element.displayName.contains(searchText) &&
              !deletedIds.contains(element.id))
          .toList();
    } else if (hasTag) {
      sortedContacts = List.of(contacts.where((element) =>
              tagIds.contains(element.id) && !deletedIds.contains(element.id)))
          .toList();
    } else {
      sortedContacts = List.of(
          contacts.where((element) => !deletedIds.contains(element.id)));
    }
    notifyListeners();
  }

  void deleteToBin() async {
    if (contact == null) {
      return;
    }
    deletedIds.add(contact!.id);
    save();
    getAll();
  }

  void delete(Contact contact) async {
    await contact.delete();
    deletedIds.remove(contact.id);
    save();
    getAll();
  }

  Future<void> create() async {
    contact = await contact?.insert();
    getAll();
  }

  Future<void> update() async {
    contact = await contact?.update();
    getAll();
  }

  void searchByTag(String? selected, List<String> data) {
    hasTag = selected != null;
    tagIds = data;

    _search();
  }
}
