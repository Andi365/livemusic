import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:livemusic/model/Artist.dart';

class ArtistNotifier with ChangeNotifier {
  List<Artist> _artistList = [];
  Artist _currentArtist;

  UnmodifiableListView<Artist> get artistList =>
      UnmodifiableListView(_artistList);

  Artist get currentArtist => _currentArtist;

  set artistList(List<Artist> artistList) {
    _artistList = artistList;
    notifyListeners();
  }

  set currentArtist(Artist currentArtist) {
    _currentArtist = currentArtist;
    notifyListeners();
  }
}
