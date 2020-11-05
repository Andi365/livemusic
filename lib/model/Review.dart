import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  var rating;
  String userId;
  Timestamp wasCreated;

  Review.fromMap(Map<String, dynamic> data) {
    rating = data['rating'];
    userId = data['userId'];
    wasCreated = data['wasCreated'];
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'userId': userId,
      'wasCreated': wasCreated,
    };
  }
}
