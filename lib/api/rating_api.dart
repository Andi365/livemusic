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
      await FirebaseFirestore.instance.collection('venues');

  /*QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection(
          '/venues/3gM7InaiFObahgUBJQCl/concerts/7T8S4iH4K684jvr9oaTr/ratings/')
      .get();

  snapshot.docs.forEach((document) {
    print('Snapshop is: ${document.data().toString()}');
  });*/

  var myReviews = FirebaseFirestore.instance
      .collectionGroup('ratings')
      .where('userId', isEqualTo: '${rating.userId}');

  QuerySnapshot snapshot1 = await myReviews.get();

  snapshot1.docs.forEach((document) {
    print('Snapshop is: ${document.data().toString()}');
  });

  /*await ratingRef
      .doc(
          '/3gM7InaiFObahgUBJQCl/concerts/7T8S4iH4K684jvr9oaTr/ratings/Y5g5Fi8Aox6SiSjHrbST')
      .set(rating.toMap(), SetOptions(merge: true));
*/
/*
  await ratingRef.doc(rating.userId).update({
    'ratings': FieldValue.arrayUnion([rating.toMap()])
  });

  print(rating.toMap());

  print('updated rating on artist ${rating.artistId}');
  */
}

getIndvRatings(String userId, RatingNotifier ratingNotifier) async {
  //getArtists(ArtistNotifier artistNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('rating').get();

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
