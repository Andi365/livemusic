import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/Rating.dart';
import 'package:livemusic/model/Review.dart';
import 'package:livemusic/model/User.dart';
import 'package:livemusic/notifier/artist_notifier.dart';
import 'package:livemusic/notifier/rating_notifier.dart';

uploadRating(
  Rating rating,
) async {
  CollectionReference ratingRef =
      await FirebaseFirestore.instance.collection('rating');

  print(rating.toMap());

  await ratingRef
      .doc('${rating.artistId}_${rating.userId}_${rating.date.seconds}')
      .set(rating.toMap(), SetOptions(merge: true));

  print('updated rating on artist ${rating.artistId}');
}

getIndvRatings(String userId, RatingNotifier ratingNotifier) async {
  //getArtists(ArtistNotifier artistNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('rating')
      .where('userId', isEqualTo: userId)
      .get();

  List<Rating> _ratings = [];

  snapshot.docs.forEach((document) {
    print('document id: ${document.id}');
    print('data: ${document.data().toString()}');
    Rating rating = Rating.fromMap(document.data());
    _ratings.add(rating);
  });

//}

  /*List<Rating> _ratings = [];

  print('userId: ${userId}');

  var myReviews = FirebaseFirestore.instance
      .collectionGroup('ratings')
      .where('userId', isEqualTo: '${userId}');

  QuerySnapshot snapshot1 = await myReviews.get();

  snapshot1.docs.forEach((document) {
    print('Snapshop is: ${document.data().toString()}');
    Rating rating = Rating.fromMap(document.data());
    print('review is: ${rating.toMap()}');
    _ratings.add(rating);
  });*/

  ratingNotifier.ratingList = _ratings;
}
