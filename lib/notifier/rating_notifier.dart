import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:livemusic/model/Rating.dart';

class RatingNotifier with ChangeNotifier {
  Rating _rating;

  Rating get rating => _rating;

  set rating(Rating rating) {
    _rating = rating;
  }
}
