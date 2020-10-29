import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/Rating.dart';

uploadRating(
  Rating rating,
) async {
  CollectionReference ratingRef =
      await FirebaseFirestore.instance.collection('rating');

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('rating').get();

  snapshot.docs.forEach((document) {
    print('Snapshop is: ${document.data().toString()}');
  });

  await ratingRef.doc(rating.userId).update({
    'ratings': FieldValue.arrayUnion([rating.toMap()])
  });

  print(rating.toMap());

  print('updated rating on artist ${rating.artistId}');
}
