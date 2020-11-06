import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/Concert.dart';
import 'package:livemusic/notifier/concert_notifier.dart';

getConcerts(String artistId, ConcertNotifier concertNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('concerts')
      .where('artistId', isEqualTo: artistId)
      .get();

  List<Concert> _concert = [];  

  snapshot.docs.forEach((document) {
    print('document id: ${document.id}');
    Concert artist = Concert.fromMap(document.data());
    _concert.add(artist);
  });

  concertNotifier.concertList = _concert;
}
