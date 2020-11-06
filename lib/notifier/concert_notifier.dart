import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:livemusic/model/Concert.dart';

class ConcertNotifier with ChangeNotifier {
  List<Concert> _concertList = [];
  Concert _currentConcert;
  

  UnmodifiableListView<Concert> get concertList =>
      UnmodifiableListView(_concertList);

  Concert get currentConcert => _currentConcert;

  set concertList(List<Concert> concertList) {
    _concertList = concertList;
    notifyListeners();
  }

  set currentConcert(Concert currentConcert) {
    _currentConcert = currentConcert;
    notifyListeners();
  }
}
