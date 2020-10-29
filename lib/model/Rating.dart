import 'package:livemusic/model/User.dart';

class Rating {
  String artistId;
  String userId = User().id;
  int rating;

  //Rating(this.artistId, this.rating, [this.userId]);
  Rating();

  Rating.fromMap(Map<String, dynamic> data) {
    artistId = data['artistId'];
    userId = data['userId'];
    rating = data['rating'];
  }

  Map<String, dynamic> toMap() {
    return {'artistId': artistId, 'userId': userId, 'rating': rating};
  }
}
