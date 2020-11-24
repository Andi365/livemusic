import 'package:cloud_firestore/cloud_firestore.dart';

class Concert {
  String concertId;
  String artistId;
  Timestamp date;
  String name;
  String venueId;
  String _venueName;

  Concert.fromMap(String concertId, Map<String, dynamic> data) {
    this.concertId = concertId;
    date = data['date'];
    name = data['name'];
    artistId = data['artistId'];
    venueId = data['venueId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'name': name,
      'artistId': artistId,
      'venueId': venueId,
    };
  }

  String get venueName => _venueName;

  set venueName(String venueName) {
    _venueName = venueName;
  }
}
