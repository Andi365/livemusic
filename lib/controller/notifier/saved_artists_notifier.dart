import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:livemusic/controller/api/database_api.dart';

class SavedArtistsNotifer with ChangeNotifier {
  final List<Favorite> _savedArtists = [];

  UnmodifiableListView<Favorite> get savedArtists =>
      UnmodifiableListView(_savedArtists);

  void remove() {
    if (_savedArtists.isNotEmpty) {
      _savedArtists.removeLast();
    }
    notifyListeners();
  }

  void add(Favorite f) {
    _savedArtists.add(f);
    notifyListeners();
  }

  void loadData() async {
    DatabaseAPI db = DatabaseAPI.instance;
    List<Favorite> list = await db.getFavorites();

    for (int i = 0; i < list.length; i++) {
      if (list[i].isFavorite) {
        _savedArtists.add(list[i]);
      }
    }
  }
}
