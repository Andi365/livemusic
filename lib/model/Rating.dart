import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/User.dart';

class Rating {
  int rating;
  String artistName;
  Timestamp concertId;
  String artistId;
  String userId = User().id;
  var wasCreated;

  //Rating(this.artistId, this.rating, [this.userId]);
  Rating();

  Rating.fromMap(Map<String, dynamic> data) {
    rating = data['rating'];
    artistName = data['artistName'];
    concertId = data['concertId'];
    artistId = data['artistId'];
    userId = data['userId'];
    wasCreated = data['wasCreated'];
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'artistName': artistName,
      'concertId': concertId,
      'artistId': artistId,
      'userId': userId,
      'wasCreated': wasCreated
    };
  }
}
