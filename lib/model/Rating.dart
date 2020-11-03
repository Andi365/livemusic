import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/User.dart';

class Rating {
  String name;
  int rating;
  String userId = User().id;
  var wasCreated;

  //Rating(this.artistId, this.rating, [this.userId]);
  Rating();

  Rating.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    rating = data['rating'];
    userId = data['userId'];
    wasCreated = data['wasCreated'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rating': rating,
      'userId': userId,
      'wasCreated': wasCreated
    };
  }
}
