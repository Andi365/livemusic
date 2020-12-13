import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:livemusic/api/database_api.dart';

class SavedBookmarksNotifer with ChangeNotifier {
  final List<Bookmark> _savedBookmarks = [];

  UnmodifiableListView<Bookmark> get savedBookmarks =>
      UnmodifiableListView(_savedBookmarks);

  void remove() {
    if (_savedBookmarks.isNotEmpty) {
      _savedBookmarks.removeLast();
    }
    notifyListeners();
  }

  void add(Bookmark b) {
    _savedBookmarks.add(b);
    notifyListeners();
  }

  void loadData() async {
    DatabaseAPI db = DatabaseAPI.instance;
    List<Bookmark> list = await db.getBookmarks();

    for (int i = 0; i < list.length; i++) {
      if (list[i].isBookmarked) {
        _savedBookmarks.add(list[i]);
      }
    }
  }
}
