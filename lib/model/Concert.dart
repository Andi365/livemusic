import 'package:cloud_firestore/cloud_firestore.dart';

class Concert {
  String artistId;
  Timestamp date;
  String name;
  String venueId;

  Concert.fromMap(Map<String, dynamic> data) {
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
}
