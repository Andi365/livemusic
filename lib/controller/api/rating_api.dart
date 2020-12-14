import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/Rating.dart';
import 'package:livemusic/notifier/rating_notifier.dart';

uploadRating(
  Rating rating,
) async {
  CollectionReference ratingRef =
      FirebaseFirestore.instance.collection('rating');

  print(rating.toMap());

  await ratingRef
      .doc('${rating.artistId}_${rating.userId}_${rating.date.seconds}')
      .set(rating.toMap(), SetOptions(merge: true));

  print('updated rating on artist ${rating.artistId}');
}

getIndvRatings(String userId, RatingNotifier ratingNotifier) async {
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

  ratingNotifier.ratingList = _ratings;
}
