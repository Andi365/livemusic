import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:livemusic/model/rating.dart';

class RatingNotifier with ChangeNotifier {
  List<Rating> _ratingList = [];
  Rating _rating;

  Rating get rating => _rating;

  set rating(Rating rating) {
    _rating = rating;
    notifyListeners();
  }

  UnmodifiableListView<Rating> get ratingList =>
      UnmodifiableListView(_ratingList);

  set ratingList(List<Rating> ratingList) {
    _ratingList = ratingList;
    notifyListeners();
  }
}
