import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/user.dart';

class Rating {
  var rating;
  String artistName;
  Timestamp date;
  String artistId;
  String userId = User().id;
  var wasCreated;

  Rating(this.artistName, this.date, this.artistId, this.wasCreated);

  Rating.fromMap(Map<String, dynamic> data) {
    rating = data['rating'].toDouble();
    artistName = data['artistName'];
    date = data['date'];
    artistId = data['artistId'];
    userId = data['userId'];
    print(date.seconds);
    wasCreated = data['wasCreated'];
  }

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'artistName': artistName,
      'date': date,
      'artistId': artistId,
      'userId': userId,
      'wasCreated': wasCreated
    };
  }
}
