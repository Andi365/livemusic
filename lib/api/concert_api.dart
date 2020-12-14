import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/concert.dart';
import 'package:livemusic/model/venue.dart';
import 'package:livemusic/controller/notifier/concert_notifier.dart';

getConcerts(String artistId, ConcertNotifier concertNotifier) async {
  Timestamp now = Timestamp.now();
  QuerySnapshot snapshot;

  snapshot = await FirebaseFirestore.instance
      .collection('concerts')
      .where('artistId', isEqualTo: artistId)
      .where('date', isGreaterThanOrEqualTo: now)
      .get();

  List<Concert> _upcoming = [];

  snapshot.docs.forEach((document) {
    print('document id: ${document.id}');
    Concert artist = Concert.fromMap(document.data());
    _upcoming.add(artist);
  });

  concertNotifier.upcomingConcerts = _upcoming;

  print('upcoming concerts? ${concertNotifier.upcomingConcerts.isNotEmpty}');

  List<Concert> _previous = [];

  snapshot = await FirebaseFirestore.instance
      .collection('concerts')
      .where('artistId', isEqualTo: artistId)
      .where('date', isLessThanOrEqualTo: now)
      .get();

  snapshot.docs.forEach((document) {
    print('document id: ${document.id}');
    Concert artist = Concert.fromMap(document.data());
    _previous.add(artist);
  });

  concertNotifier.previousConcerts = _previous;

  print('previous concerts? ${concertNotifier.previousConcerts.isNotEmpty}');

  getVenuesConcertView(concertNotifier);
}

Future<Concert> getConcert(String concertId) async {
  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('concerts')
      .doc(concertId)
      .get();
  return Concert.fromMap(doc.data());
}

Future<Venue> getVenue(String venueId) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('venues').doc(venueId).get();
  return Venue.fromMap(doc.id, doc.data());
}

getVenuesConcertView(ConcertNotifier concertNotifier) async {
  List<Future> futures = [];
  //print('previous concert length: ${concertNotifier.previousConcerts.length}');
  for (int i = 0; i < concertNotifier.previousConcerts.length; i++) {
    futures.add(getVenue(concertNotifier.previousConcerts[i].venueId));
  }

  //print('upcoming concert length: ${concertNotifier.upcomingConcerts.length}');
  for (int i = 0; i < concertNotifier.upcomingConcerts.length; i++) {
    futures.add(getVenue(concertNotifier.upcomingConcerts[i].venueId));
  }

  await Future.wait(futures).then(
    (value) {
      if (concertNotifier.previousConcerts.length != 0) {
        for (int i = 0; i < concertNotifier.previousConcerts.length; i++) {
          concertNotifier.previousConcerts[i].venueName = value[i].name;
        }
      }

      if (concertNotifier.upcomingConcerts.length != 0) {
        for (int i = 0; i < concertNotifier.upcomingConcerts.length; i++) {
          concertNotifier.upcomingConcerts[i].venueName =
              value[i + concertNotifier.previousConcerts.length].name;
        }
      }
    },
  );
}
