import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/Artist.dart';
import 'package:livemusic/notifier/artist_notifier.dart';

getArtists(ArtistNotifier artistNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('Artist').get();

  List<Artist> _artist = [];

  snapshot.docs.forEach((document) {
    Artist artist = Artist.fromMap(document.data());
    _artist.add(artist);
  });

  artistNotifier.artistList = _artist;
}
