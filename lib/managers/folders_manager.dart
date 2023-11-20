import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:secret_fans/main.dart';
import 'package:secret_fans/managers/contacts_manager.dart';

import '../models/folder.dart';

class FoldersManager extends ChangeNotifier {
  static const deletedFoldersKey = 'DELETED_FOLDERS_KEY';
  static const foldersKey = 'FOLDERS_KEY';

  final ContactsManager contactsManager;

  List<Folder> _folders = [];
  List<String> deletedIds = [];

  Folder? folder;

  List<String> get names => _folders.map((e) => e.name).toList();

  List<Contact> get contacts => contactsManager.contacts;

  List<Folder> get deletedFolders =>
      _folders.where((element) => deletedIds.contains(element.name)).toList();

  List<Folder> get folders =>
      _folders.where((element) => !deletedIds.contains(element.name)).toList();

  FoldersManager({required this.contactsManager}) {
    init();
  }

  void init() {
    final names = preferences.getStringList(foldersKey) ?? [];
    deletedIds = preferences.getStringList(deletedFoldersKey) ?? [];
    for (int i = 0; i < names.length; i++) {
      var name = names[i];
      var ids = preferences.getStringList('$foldersKey$name') ?? [];
      var tempContacts =
          contacts.where((element) => ids.contains(element.id)).toList();

      var folder = Folder(name: name, contacts: tempContacts);
      _folders.add(folder);
    }

    notifyListeners();
  }

  void save() {
    preferences.setStringList(foldersKey, names);
    for (var item in _folders) {
      var ids = item.contacts.map((e) => e.id).toList();
      var name = item.name;
      preferences.setStringList('$foldersKey$name', ids);
    }
  }

  void createFolder(String name) {
    folder = Folder(name: name, contacts: []);
  }

  void addContacts(List<Contact> contacts) {
    if (folder == null) {
      return;
    }
    folder = folder!.copyWith(contacts: contacts);
    _folders.add(folder!);
    notifyListeners();

    folder = null;
    save();
  }

  void editContacts(List<Contact> contacts) {
    if (folder == null) {
      return;
    }

    var index = _folders.indexOf(folder!);
    _folders.removeAt(index);

    folder = folder!.copyWith(contacts: contacts);
    _folders.insert(index, folder!);
    notifyListeners();

    save();
  }

  void removeFolder(Folder folder) {
    _folders.remove(folder);
    deletedIds.remove(folder.name);
    notifyListeners();

    preferences.remove('$foldersKey${folder.name}');
    preferences.setStringList(foldersKey, names);
    preferences.setStringList(deletedFoldersKey, deletedIds);
  }

  void removeToBin(Folder folder) {
    deletedIds.add(folder.name);
    notifyListeners();
    preferences.setStringList(deletedFoldersKey, deletedIds);
  }

  void renameFolder(String name, Folder folder) {
    var index = _folders.indexOf(folder);
    _folders.removeAt(index);
    _folders.insert(index, folder.copyWith(name: name));
    notifyListeners();
    save();
  }

  void reorder(List<Folder> folders) {
    _folders = folders;
    notifyListeners();
    preferences.setStringList(foldersKey, names);
  }
}
