import 'package:flutter/cupertino.dart';
import 'package:secret_fans/main.dart';
import 'package:secret_fans/managers/contacts_manager.dart';

class TagManager extends ChangeNotifier {
  static const tagsKey = 'TAGS_KEY';

  final ContactsManager contactsManager;

  List<String> tags = [];

  String? selected;

  TagManager(this.contactsManager) {
    init();
  }

  void init() {
    tags = preferences.getStringList(tagsKey) ?? [];
    notifyListeners();
  }

  void save() async {
    preferences.setStringList(tagsKey, tags);
  }

  void create(String name) {
    if (tags.contains(name)) {
      return;
    }
    tags.add(name);
    notifyListeners();
    save();
  }

  remove(String name) {
    tags.remove(name);
    preferences.remove('tag=$name');
    notifyListeners();
    save();
  }

  List<String> getTagsForId(String? id) {
    if (id == null) {
      return [];
    }

    List<String> result = [];
    for (var tag in tags) {
      var data = preferences.getStringList('tag=$tag') ?? [];
      if (data.contains(id)) {
        result.add(tag);
      }
    }
    return result;
  }

  void addTagForId(String tag, String id) async {
    var data = preferences.getStringList('tag=$tag') ?? [];
    if (data.contains(id)) {
      return;
    }

    data.add(id);
    await preferences.setStringList('tag=$tag', data);
    notifyListeners();
  }

  void addTagsForId(String id, List<String> tags) async {
    for (var tag in this.tags) {
      var data = preferences.getStringList('tag=$tag') ?? [];

      if (tags.contains(tag)) {
        if (data.contains(id)) {
          continue;
        } else {
          data.add(id);
          await preferences.setStringList('tag=$tag', data);
        }
      } else {
        data.remove(id);
        await preferences.setStringList('tag=$tag', data);
      }
    }

    notifyListeners();
  }

  void select(String tag) {
    if (selected == null) {
      selected = tag;
    } else if(selected == tag){
      selected = null;
    } else {
      selected = tag;
    }

    var data = preferences.getStringList('tag=$tag') ?? [];

    contactsManager.searchByTag(selected, data);

    notifyListeners();
  }
}
