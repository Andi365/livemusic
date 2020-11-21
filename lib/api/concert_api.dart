import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:livemusic/model/Concert.dart';
import 'package:livemusic/model/Venue.dart';
import 'package:livemusic/notifier/concert_notifier.dart';
import 'package:provider/provider.dart';

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
}

Future<Venue> getVenue(String venueId) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('venues').doc(venueId).get();
  return Venue.fromMap(doc.data());
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
      for (int i = 0; i < futures.length; i++) {
        if (i < concertNotifier.previousConcerts.length &&
            concertNotifier.previousConcerts.length != 0) {
          concertNotifier.previousConcerts[i].venueName = value[i].name;
        }
        if (i >=
                (concertNotifier.previousConcerts.length +
                        concertNotifier.upcomingConcerts.length) -
                    1 &&
            concertNotifier.upcomingConcerts.length != 0) {
          concertNotifier
              .upcomingConcerts[i - concertNotifier.previousConcerts.length]
              .venueName = value[i].name;
        }
      }
    },
  );
}
