import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:livemusic/model/concert.dart';

class ConcertNotifier with ChangeNotifier {
  List<Concert> _upcomingConcerts = [];
  List<Concert> _previousConcerts = [];
  Concert _currentConcert;

  //upcoming concerts
  UnmodifiableListView<Concert> get upcomingConcerts =>
      UnmodifiableListView(_upcomingConcerts);

  set upcomingConcerts(List<Concert> upcomingConcerts) {
    _upcomingConcerts = upcomingConcerts;
    notifyListeners();
  }

  // previous concerts
  UnmodifiableListView<Concert> get previousConcerts =>
      UnmodifiableListView(_previousConcerts);

  set previousConcerts(List<Concert> previousConcerts) {
    _previousConcerts = previousConcerts;
    notifyListeners();
  }

  Concert get currentConcert => _currentConcert;

  set currentConcert(Concert currentConcert) {
    _currentConcert = currentConcert;
    notifyListeners();
  }
}
