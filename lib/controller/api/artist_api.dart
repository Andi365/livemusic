import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livemusic/model/Artist.dart';
import 'package:livemusic/notifier/artist_notifier.dart';

Future<List<Artist>> getArtists(ArtistNotifier artistNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('Artist').get();

  List<Artist> _artist = [];

  snapshot.docs.forEach((document) {
    print('document id: ${document.id}');
    Artist artist = Artist.fromMap(document.id, document.data());
    _artist.add(artist);
  });

  artistNotifier.artistList = _artist;
  return _artist;
}

Future<Artist> getArtist(String artistId) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('Artist').doc(artistId).get();

  return Artist.fromMap(artistId, doc.data());
}
